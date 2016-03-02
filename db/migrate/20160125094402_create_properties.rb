class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.integer :organization_id, index: true
      t.string :entity_type, index: true
      t.string :name
      t.string :value_type
      t.string :default_value
      t.string :choices, array: true, default: []
      t.timestamps
    end

  end
end
