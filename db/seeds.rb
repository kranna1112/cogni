master = Organization.create!(name: 'MobilityEmpowered', role: 'owner', internal: true, active: true)
puts "Site Owner created!\n".colorize(:green)

# Super Admin
print "Enter an email address for your super admin account:"
email = STDIN.gets.chomp
print "Enter password(at least 8 letters):"
password = STDIN.gets.chomp
print "Enter the first name:"
first = STDIN.gets.chomp
print "Enter the last name:"
last = STDIN.gets.chomp
user = User.new(email: email, password: password, password_confirmation: password, first_name: first, last_name: last)
user.confirmed_at = Time.now
user.super_admin = true
user.company_id = master.id
user.organization_id = master.id
user.role = 'admin'
user.active = true
user.save!
puts "The super admin account is created!\n".colorize(:green)

# Agency
agency = Organization.create!(name: 'Bristol Global', role: 'agency', active: true)
relationship = Relationship.create!(parent_id: master.id, child_id: agency.id, status: 'active', role: 'customer')
puts "Bristol Global (agency) created!\n".colorize(:green)

# Customer
company = Organization.create!(name: 'Cognizant', role: 'customer', active: true)
relationship = Relationship.create!(parent_id: agency.id, child_id: company.id, status: 'active', role: 'customer')
puts "Cognizant (customer) created!\n".colorize(:green)
