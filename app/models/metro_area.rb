class MetroArea < Flexirest::Base

  base_url "http://api.backend.dev/public/v1"

  get :all, "/metro_areas"
  get :find, "/metro_areas/:id"

end