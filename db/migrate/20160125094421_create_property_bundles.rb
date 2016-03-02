class CreatePropertyBundles < ActiveRecord::Migration
  def change
    create_table :property_bundles do |t|
      t.integer :organization_id, index: true
      t.integer :property_id, index: true
      t.integer :bundle_id, index: true
    end
  end
end
