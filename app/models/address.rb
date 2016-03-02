class Address < ActiveRecord::Base
  belongs_to :project, polymorphic: true
end
