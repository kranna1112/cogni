class CreateBundles < ActiveRecord::Migration
  def change
    create_table :bundles do |t|
      t.integer :organization_id, index: true
      t.string :entity_type, index: true
      t.string :name, index: true
      t.timestamps
    end

  end
end
