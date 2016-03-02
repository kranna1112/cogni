class ServiceType < Flexirest::Base

  get :all, '/service_types'
  get :find, '/service_types/:id'

end
