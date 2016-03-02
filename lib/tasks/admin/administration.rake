# lib/tasks/admin/create_super_admin.rake
namespace :admin do
  desc 'Create a super admin account'
  task :create_super_admin => :environment do
    print "Enter the email of the super admin user:"
    email = STDIN.gets.chomp

    # Find Internal Organization
    org = Organization.where(internal: true).first
    if org

      user = User.where(email: email).first_or_initialize

      if user.new_record?
        user.password = Devise.friendly_token.first(8)

        print "Enter first name for admin account:"
        user.first_name = STDIN.gets.chomp

        print "Enter last name for admin account:"
        user.last_name = STDIN.gets.chomp

        if Rails.env.production?
          user.password = Devise.friendly_token.first(8)
        else
          print "Enter password(at least 8 letters):"
          user.password = STDIN.gets.chomp
        end

        user.confirmed_at = Time.now

        user.save!

        Notifier.new_user_welcome(org, user).deliver
      else
        puts "User already exists, adding it to owner organization."
      end

      user.role = 'admin'
      user.organization_id = org.id

      # will delegate to user.membership
      user.save!

      # notification
      Notifier.new_organization_admin_welcome(org, user).deliver

      puts "Super Admin done!\n"

      # for existing user, user.password is nil
      if Rails.env.production? and user.password
        user.send_reset_password_instructions
        puts "User will receive an email to reset password for their account"
      end
    else
      'ERROR: Owner Organization Has Not Been Established'
    end
  end
end
