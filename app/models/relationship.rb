class Relationship < ActiveRecord::Base

  belongs_to :parent, class_name: Organization, foreign_key: :parent_id
  belongs_to :child, class_name: Organization, foreign_key: :child_id

  scope :customer, -> {where(role: 'customer')}
  scope :active, -> { where( status: 'active' ) }

  STATUSES = %w(proposed active retired)

  STATUSES.each do |s|
    define_method(s + '?') { self.status.to_s == s }
  end

  ROLES = %w(customer)

  ROLES.each do |r|
    define_method('is_' + r + '?') { self.role.to_s == r }
  end

  validates :role, presence: true, inclusion: {in: ROLES}
  validates :status, presence: true, inclusion: {in: STATUSES}
  validates :parent_id, presence: true
  validates :child_id, uniqueness: { scope: [:parent_id, :role] }, presence: true

  def partner_name
    self.child.name
  end

end