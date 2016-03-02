class CreateRelationship < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :parent_id, null: false, index: true
      t.integer :child_id, null: false, index: true
      t.string :role, null: false
      t.string :status, null: false
      t.timestamps null: false
    end
  end
end
