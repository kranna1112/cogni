class ServiceRequest < Flexirest::Base

  # verbose!


  get :all, '/service_requests', :requires => [:relocation_id]
  get :find, '/service_requests/:id'#, :has_many => {:service_orders => ServiceOrder}
  post :create, '/service_requests', :requires => [:relocation_id, :agency_id, :customer_id, :service_type_id]
end
