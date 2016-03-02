class AddDeviseSecurityExtensionPasswordExpirableColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_changed_at, :datetime
    add_index :users, :password_changed_at

    User.find_each do |u|
      u.update(password_changed_at: Time.now)
    end
  end
end
