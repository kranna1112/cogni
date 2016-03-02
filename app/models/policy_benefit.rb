class PolicyBenefit < ActiveRecord::Base
  belongs_to :policy
  has_many :relocation_benefits
  has_many :relocations, through: :relocation_benefits

  validates :name, presence: true
  # validates_uniqueness_of :name, scope: [:policy_id]
  # validates :service_type_id, presence: true

  def service_type
    return nil unless self.service_type_id 
    ServiceType.find(self.service_type_id)
  end

end
