class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.references :relocation_service, index: true, null: false
      t.references :organization_id, index: true
      t.integer :bundle_id, index: true
      t.hstore :property_values
      t.timestamps null: false
    end

    add_index :services, :property_values, using: :gin
  end
end
