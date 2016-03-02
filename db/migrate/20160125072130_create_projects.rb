class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.references :organization, index: true, null: false
      t.integer :customer_id, index: true, null: false
      t.string :reference_number
      t.string :project_manager_name
      t.string :project_manager_email
      t.string :client_manager_name
      t.string :client_manager_email
      t.timestamps null: false
    end
  end
end
