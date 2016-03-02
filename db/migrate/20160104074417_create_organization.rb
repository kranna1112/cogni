class CreateOrganization < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :role, null: false
      t.boolean :active, null: false, default: false
      t.boolean :internal, null: false, default: false
      t.integer :users_count, default: 0, null: false
      t.integer :access_id, index: true
      t.string :secret_key
      t.timestamps null: false
    end
  end
end
