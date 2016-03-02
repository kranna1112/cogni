class ServiceException < ActiveRecord::Base

  belongs_to :relocation_service
  belongs_to :resolver, class_name: 'User', foreign_key: 'resolver_id'
  belongs_to :requester, class_name: 'User', foreign_key: 'requester_id'

  STATUSES = %w(draft requested approved rejected)

  STATUSES.each do |s|
    define_method(s + '?') { self.status.to_s == s }
  end


end
