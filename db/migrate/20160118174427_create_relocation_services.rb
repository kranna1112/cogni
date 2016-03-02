class CreateRelocationServices < ActiveRecord::Migration
  def change
    create_table :relocation_services do |t|
      t.references :relocation, index: true
      t.references :policy_line, index: true
      t.string :name, null: false
      t.monetize :budget
      t.monetize :actual
      t.string :status
      t.timestamps null: false
    end
  end
end
