class RelocationBenefit < ActiveRecord::Base

  include AASM

  belongs_to :relocation
  belongs_to :policy_benefit
  has_many :service_exceptions
  has_one :service_order

  aasm column: 'status' do
    state :authorized, initial: true
    state :requested
    state :quoted
    state :ordered
    state :completed

    event :request do
      transitions from: :authorized, to: :requested
    end

  end

end
