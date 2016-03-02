class CreateRelocations < ActiveRecord::Migration
  def change
    create_table :relocations do |t|
      t.references :employee, index: true
      t.references :organization, index: true
      t.integer :agency_id, index: true
      t.references :policy, index: true
      t.datetime :start_at
      t.datetime :end_at
      t.monetize :budget
      t.string :status
      t.integer :origin_metro_area_id, index: true
      t.integer :destination_metro_area_id, index: true
      t.boolean :onboarded, default: false
      t.integer :initiator_id
      t.hstore :property_values
      t.timestamps null: false
    end
  end
end
