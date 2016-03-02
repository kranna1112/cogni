class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true, index: true
      t.string :address_1
      t.string :address_2
      t.integer :country_id
      t.integer :subdivision_id
      t.integer :metro_area_id
      t.integer :postal_code_id
      t.string :postal_code
      t.integer :city_id
      t.string :city
      t.timestamps null: false
    end
  end
end
