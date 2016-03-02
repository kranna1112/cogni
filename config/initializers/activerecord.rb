require Rails.root.join('app', 'models', 'lib', 'acts_as_substrate')

ActiveRecord::Base.extend(ActsAsSubstrate::Base)
