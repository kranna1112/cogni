class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable,
          :password_expirable, :password_archivable, :session_limitable, :expirable

  audited
  has_associated_audits

  # The company the user belongs to and was created in
  belongs_to :company, class_name: Organization, foreign_key: :company_id, counter_cache: :users_count

  # The membership record that will drive the user experience. User can switch among memberships and the current one is defined here
  has_one :current, -> { where active: true}, class_name: 'Membership'
  has_one :organization, through: :current

  # This represents all of the organizations that the user is associated with and the role for each
  has_many :memberships, dependent: :delete_all
  has_many :organizations, through: :memberships
  has_one :employee

  #added for user name
  attr_accessor :login

  validates :company_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :user_name, uniqueness: {case_sensitive: false}, length: {minimum: 4, maximum: 20}, allow_blank: true
  validates_associated :company

  after_create :save_current

  delegate :role, :role=, :organization_id, :organization_id=, :is_admin?, :is_manager?, :is_worker?, :is_transferee?, :active, :active=,
           :default, :default=, :can_access_finance?, :can_access_legal?, :can_access_finance=, :can_access_legal=, to: :safe_current

  scope :without_employee, -> { joins("RIGHT JOIN employees ON users.id != employees.user_id") }

  attr_accessor :finance, :legal

  def name
    if first_name && last_name
      [first_name, last_name].join(' ')
    elsif first_name || last_name
      first_name || last_name
    else
      email
    end
  end

  def name_email
    [name, email].join(' | ')
  end

  def active_organizations
    Organization.joins(:memberships).where('memberships.user_id' => self.id, active: true).distinct.load
  end

  def has_multiple_organizations?
    self.active_organizations.size > 1
  end

  def member_of?(organization_id)
    Organization.joins(:memberships).where('memberships.user_id' => self.id, id: organization_id).exists?
  end

  def notify_organization_access!(organization)
    # if user never logins, allow user to reset password
    if sign_in_count == 0
      Notifier.delay.new_user_welcome(organization, self)
    end

    if self.is_admin?
      Notifier.delay.new_organization_admin_welcome(organization, self)
    else
      Notifier.delay.new_organization_access_welcome(organization, self)
    end
  end

  # https://github.com/ryanb/cancan/wiki/ability-for-other-users
  # def ability
  #   @ability ||= Ability.new(self)
  # end
  # delegate :can?, :cannot?, :to => :ability

  # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(user_name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  # instead of deleting, indicate the user requested a delete & timestamp it
  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  # ensure user account is active
  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end

  def transferee!
    self.role = 'transferee'
    self.organization_id = self.company_id
    self.can_access_finance = false
    self.can_access_legal = false
    self.active = true
    self.default = true
    self.save
  end

  def has_employee?
    self.employee.present?
  end

  private

  def safe_current
    self.current || self.build_current
  end

  def save_current
    safe_current.user_id = self.id
    safe_current.save if safe_current.changed?
  end

end
