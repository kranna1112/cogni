class CreateEstimates < ActiveRecord::Migration
  def change
    create_table :estimates do |t|
      t.references :relocation, index: true, null: false
      t.string :status
      t.text :comments
      t.monetize :total
      t.datetime :calculated_at
      t.integer :resolver_id
      t.datetime :resolved_at
      t.timestamps null: false
    end
  end
end
