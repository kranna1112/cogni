class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.references :organization, index: true
      t.references :user, index: true
      t.string :first_name, null: false
      t.string :middle_name
      t.string :last_name, null: false
      t.hstore :property_values
      t.integer :relocations_count, default: 0, null: false

      t.timestamps null: false
    end
  end
end
