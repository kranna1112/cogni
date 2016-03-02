class Catalog < Flexirest::Base

  # base_url defined in environment config

  get :find, "/catalogs/:id"

end