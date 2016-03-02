class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :organization_id
      t.string :stream_name
      t.string :stream_type
      t.integer :stream_id
      t.text :content
      t.string :event_type
      t.integer :initiator_id
      t.timestamps null: false
    end
    add_index :events, [:organization_id, :stream_type, :stream_id, :stream_name], name: 'events_index'
  end
end
