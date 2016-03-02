class Service < ActiveRecord::Base
  acts_as_substrate bundles: true

  belongs_to :relocation_service
  has_many :orders
  has_many :events, as: :stream
end
