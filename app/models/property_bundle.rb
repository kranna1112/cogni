class PropertyBundle < ActiveRecord::Base

  belongs_to :property
  belongs_to :bundle
  belongs_to :organization

end
