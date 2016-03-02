class Relocation < ActiveRecord::Base

  include AASM

  belongs_to :employee
  belongs_to :organization
  belongs_to :agency, class_name: Organization, foreign_key: :agency_id
  has_many :relocation_benefits
  has_many :estimates
  # has_one :policy
  belongs_to :policy
  belongs_to :project
  has_many :events, as: :stream
  belongs_to :initiator, class_name: User, foreign_key: :initiator_id
  has_one :origin_address, class_name: Address, as: :addressable
  # belongs_to :origin_metro_area, class_name: MetroArea, foreign_key: :origin_metro_area_id
  # belongs_to :destination_metro_area, class_name: MetroArea, foreign_key: :destination_metro_area_id

  accepts_nested_attributes_for :employee, :relocation_benefits

  # STATUSES = %w(initiated onboarded estimated active cancelled completed suspended closed)
  #
  # STATUSES.each do |s|
  #   define_method(s + '?') { self.status.to_s == s }
  # end

  scope :active, -> { where( status: 'active' ) }
  scope :initiated, -> { where( status: 'initiated')}
  scope :onboard, -> { where( status: 'onboard')}

  after_create :create_relocation_benefits

  def create_relocation_benefits
    if policy
      policy.policy_benefits.each do |policy_benefit|
        self.relocation_benefits.create({policy_benefit_id: policy_benefit.id, name: policy_benefit.name})
      end
    end
  end

  def service_requests
    ServiceRequest.all(relocation_id: self.id)
  end

  def service_orders
    ServiceOrder.all(relocation_id: self.id)
  end

  def origin_metro_area
    MetroArea.find(self.origin_metro_area_id)
  end

  def destination_metro_area
    MetroArea.find(self.destination_metro_area_id)
  end

  def create! params
    user = find_or_create_user(params, self)
    employee = user.has_employee? ? user.employee.id : (self.create_employee user).id
    create_relocation!(self, user, employee)
  end

  aasm column: 'status' do
    state :initiated, initial: true
    state :onboarded
    state :estimated
    state :active
    state :cancelled
    state :completed
    state :suspended
    state :closed

    event :onboard do
      transitions from: :initiated, to: :onboarded
    end

    event :estimate do
      transitions from: :onboarded, to: :estimated
    end

    event :active do
      transitions from: [:estimated, :suspended], to: :active
    end

    event :cancel do
      transitions from: [:active, :estimated, :onboarded, :initiated], to: :cancelled
    end

    event :complete do
      transitions from: :active, to: :completed
    end

    event :suspend do
      transitions from: :active, to: :suspended
    end

    event :close do
      transitions from: [:complete, :cancelled, :suspended], to: :closed
    end


  end

  # For creating relocation user
  def create_user params
    user = User.new
    user.email = params[:email]
    user.first_name = params[:first_name]
    user.last_name = params[:last_name]
    user.company_id = self.organization_id
    user.password =  Devise.friendly_token.first(8)
    user.save
    user.skip_confirmation!
    user.transferee!
    user
  end

  # For creating employee
  def create_employee user
    employee = Employee.new
    employee.organization_id = user.company_id
    employee.first_name = user.first_name
    employee.last_name = user.last_name
    employee.user_id = user.id
    employee.save
    employee
  end

  def relocation_points
    [origin_metro_area_id, destination_metro_area_id].join('-')
  end

  # This method find find user by their email if not found user than create it.
  def find_or_create_user(params, relocation)
    if User.exists?(email: params[:user][:email])
      User.find_by_email params[:user][:email]
    else
      relocation.create_user params[:user]
    end
  end

  # It validate and create relocation
  def create_relocation!(relocation, user, employee)
    if user.errors.present?
      user.errors.messages.keys.each do |e|
        relocation.errors.messages[e] = user.errors.messages[e]
      end
    else
      relocation.employee_id = employee
      relocation.save
    end
    relocation
  end

end
