class Bundle < ActiveRecord::Base

  belongs_to :organization
  has_many :property_bundles, dependent: :destroy
  has_many :properties, through: :property_bundles

  validates :name, uniqueness: { scope: [:organization_id, :entity_type] }, presence: true
end
