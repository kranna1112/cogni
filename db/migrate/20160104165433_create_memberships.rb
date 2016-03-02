class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id, null: false, index: true
      t.integer :organization_id, null: false, index: true
      t.string :role
      t.boolean :default, default: false
      t.boolean :can_access_legal, default: false
      t.boolean :can_access_finance, default: false
      t.boolean :active, default: false
      t.timestamps null: false
    end
  end
end
