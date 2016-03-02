class Policy < ActiveRecord::Base

  belongs_to :organization
  has_many :policy_benefits, autosave: true, validate: true
  accepts_nested_attributes_for :policy_benefits, reject_if: :all_blank
  validates_associated :policy_benefits

  scope :active, -> { where(status: 'active') }

  STATUSES = %w(draft active cancelled expired)

  STATUSES.each do |s|
    define_method(s + '?') { self.status.to_s == s }
  end

  validates :organization_id, :name, :description, :start_at, presence: true
  validates :description, length: {minimum: 10}
  validates :status, presence: true, inclusion: {in: STATUSES}
  validates_uniqueness_of :name, scope: [:organization_id], conditions: -> { where(status: 'active') }
  validates_associated :organization
  validate :end_after_start

  validate :uniqueness_of_policy_benefits

  def start_at=(time)
    return if time.blank?
    if time.is_a? String
      time = parse_time(time)
    end

    self[:start_at] = time
  end

  def end_at=(time)
    return if time.blank?
    if time.is_a? String
      time = parse_time(time)
    end

    self[:end_at] = time
  end

  private

  def parse_time(str)
    DateTime.strptime(str, "%m-%d-%Y")
  end

  def end_after_start
    return if end_at.blank? || start_at.blank?

    if end_at < start_at
      errors.add(:end_at, "must be after the start date.")
    end
  end

  def uniqueness_of_policy_benefits
    hash = {}
    policy_benefits.each do |policy_benefit|
      if hash[policy_benefit.name]
        errors.add(:"policy_benefit.name", "duplicate error")
        if errors[:"policy_benefit.name"].blank?
          policy_benefit.errors.add(:name, "has already been taken") 
        end
      end
      hash[policy_benefit.name] = true
    end
  end

end