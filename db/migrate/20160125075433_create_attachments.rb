class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :organization_id
      t.string :attachable_type
      t.integer :attachable_id
      t.string :name
      t.string :content_type
      t.integer :file_size
      t.integer :creator_id
      t.string :status
      t.string :acl, :default => 'public_read'
      t.string :uuid

      t.timestamps
    end

    add_index :attachments, [:organization_id, :attachable_id, :attachable_type], name: 'index_attachable_on_attachments'
  end
end
