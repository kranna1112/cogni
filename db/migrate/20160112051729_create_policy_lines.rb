class CreatePolicyLines < ActiveRecord::Migration
  def change
    create_table :policy_lines do |t|
      t.references :service_type, index: true
      t.string :name, null: false
      t.string :description

      t.timestamps null: false
    end
  end
end
