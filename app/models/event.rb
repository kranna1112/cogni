class Event < ActiveRecord::Base
  belongs_to :stream, :polymorphic => true
  belongs_to :initiator, class_name: 'User', foreign_key: 'initiator_id'

end
