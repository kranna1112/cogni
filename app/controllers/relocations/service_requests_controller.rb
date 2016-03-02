class Relocations::ServiceRequestsController < ApplicationController

  # CanCanCommunity - automatically authorize all actions in a RESTful style resource controller
  load_and_authorize_resource :relocation
  load_and_authorize_resource :service_requests, :through => :relocation

  def index
    # should auto retrieve
  end

  def new
    @service_request = @relocation.service_requests.new
  end

  def create
    @service_request = @relocation.service_requests.create(service_request_params)
    @service_requests = ServiceRequest.where(relocation: @relocation)
  end

  def show

  end

  private

  def service_request_params
    params.require(:service_request).permit(:relocation_id, :service_type_id, :agency_id, :customer_id, :property_values)
  end

end