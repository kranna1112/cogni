class CreatePolicies < ActiveRecord::Migration
  def change
    create_table :policies do |t|
      t.references :organization, index: true
      t.string :name, null: false
      t.text :description
      t.string :status, null: false
      t.datetime :start_at
      t.datetime :end_at
      t.text :content
      t.hstore :versions, array: true, default: '{}', null: false
      t.hstore :property_values

      t.timestamps null: false
    end
  end
end
