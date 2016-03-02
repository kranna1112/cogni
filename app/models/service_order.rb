class ServiceOrder < Flexirest::Base

  # verbose!

  get :all, '/service_orders', :requires => [:relocation_id]
  get :find, '/service_orders/:id'#, :has_many => {:service_orders => ServiceOrder}

end

