class CreateServiceTypes < ActiveRecord::Migration
  def change
    create_table :service_types do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :status, null: false
      t.integer :me_service_type_id, null: false
      t.hstore :property_values
      t.timestamps null: false
    end
  end
end
