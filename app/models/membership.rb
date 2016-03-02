class Membership < ActiveRecord::Base

  belongs_to :user
  belongs_to :organization, counter_cache: :users_count

  audited associated_with: :user


  ROLES = %w(admin manager worker transferee)

  validates :role, presence: true, inclusion: {in: ROLES}
  validates :organization_id, presence: true
  validates :user_id, uniqueness: { scope: [:organization_id] }, presence: true

  ROLES.each do |r|
    define_method('is_' + r + '?') { self.role.to_s == r }
  end

end
