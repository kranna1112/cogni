class Organization < ActiveRecord::Base

  has_many :users, foreign_key: :company_id

  has_many :memberships, dependent: :delete_all
  has_many :members, class_name: 'User', through: :memberships, foreign_key: :company_id

  has_many :relationships, foreign_key: :parent_id
  has_many :partners, through: :relationships, source: :child
  has_many :relocations
  has_many :employees
  has_many :policies
  has_many :projects, foreign_key: :company_id

  ROLES = %w(agency customer owner)

  ROLES.each do |r|
    define_method('is_' + r + '?') { self.role.to_s == r }
  end

  validates :name, presence: true, uniqueness: {case_sensitive: false},
            length: {minimum: 3, maximum: 50}
  validates :role, presence: true, inclusion: {in: ROLES}
  validates :secret_key, uniqueness: {case_sensitive: true}, allow_blank: true

end