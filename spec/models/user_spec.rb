require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with email, first_name, last_name, password, password_confirmation, company_id'
  it 'is not created as super_admin'
  it 'is valid to log in'
end
