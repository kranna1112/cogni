# Following types are supported:
#    string  - Short String
#    text    - Paragraphs of Text
#    choice  - Dropdown Choice
#    number  - Numbers
#
class Property < ActiveRecord::Base

  VALUE_TYPES = %w(string text choice number)

  has_many :property_bundles, dependent: :destroy
  has_many :bundles, through: :property_bundles
  belongs_to :organization

  validates :name, uniqueness: { scope: [:organization_id, :entity_type] }, presence: true
  validates :value_type, presence: true, inclusion: {in: VALUE_TYPES}

  after_destroy :cleanup_obsolete_data

  def in_use?
    self.entity_type.constantize.where("EXIST(property_values, '?')", self.id).count > 0
  end

  private

  def cleanup_obsolete_data
    self.entity_type.constantize.update_all([%(property_values = DELETE("property_values", ?)), self.id.to_s])
  end
end
