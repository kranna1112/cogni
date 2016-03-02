module Admin
  class ServiceTypesController < Admin::BaseController

    before_action :load_resource, only: [:show, :update, :edit]

    def index
      @service_types = ServiceType.all
    end

    def new
      @service_type = ServiceType.new
      @service_types = Backend.get_service_types
      @service_types = @service_types.parsed_response
    end

    def create
      # retrieve service types from Mobility Empowered
      @me_service_type = Backend.get_service_type(params[:service_type][:me_service_type_id])
      @me_service_type = @me_service_type.parsed_response

      # create new service type
      @service_type = ServiceType.new
      @service_type.me_service_type_id = @me_service_type['id']
      @service_type.name = @me_service_type['name']
      @service_type.description = @me_service_type['description']
      @service_type.status = params[:service_type][:status]
      @service_type.save

      @service_types = ServiceType.all
    end

    def edit

    end

    def update

    end

    private

    def service_type_params
      params.require(:service_type).permit(:me_service_type_id, :status)
    end

    def load_resource
      @service_type = ServiceType.find(params[:id])
    end

  end
end