class Country < ActiveResource::Base

  self.site = "http://api.backend.dev/public/v1"

  has_many :subdivisions

end