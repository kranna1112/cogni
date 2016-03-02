class Estimate < ActiveRecord::Base

  belongs_to :relocation
  has_one :attachment, as: :attachable
  belongs_to :resolver, class_name: 'User', foreign_key: 'resolver_id'

  STATUSES = %w(calculated pending approved rejected)

  STATUSES.each do |s|
    define_method(s + '?') { self.status.to_s == s }
  end

end
