class Employee < ActiveRecord::Base

  belongs_to :user
  belongs_to :organization
  has_many :relocations

  validates :first_name, :last_name, :organization_id, presence: true
  validates_associated :user, :organization

  def name
    [first_name, last_name].join(' ')
  end

end
