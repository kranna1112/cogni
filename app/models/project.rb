class Project < ActiveRecord::Base
  belongs_to :organization
  belongs_to :customer, class_name: Organization, foreign_key: :company_id
  has_one :address, as: :addressable
end
