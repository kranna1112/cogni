class CreateServiceExceptions < ActiveRecord::Migration
  def change
    create_table :service_exceptions do |t|
      t.references :relocation_services, index: true, null: false
      t.monetize :amount
      t.text :comments
      t.string :status
      t.integer :resolver_id
      t.datetime :resolved_at
      t.integer :requester_id
      t.datetime :requested_at
      t.timestamps null: false
    end
  end
end
