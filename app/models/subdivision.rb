class Subdivision < ActiveResource::Base

  self.site = "http://api.backend.dev/public/v1"

  belongs_to :country
  has_many :metro_areas

end