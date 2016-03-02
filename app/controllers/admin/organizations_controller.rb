module Admin
  class OrganizationsController < Admin::BaseController

    before_action :load_resource, only: [:show, :update, :edit]

    def index
      @organizations = Organization.all
    end

    def show
    end

    def new
      @organization = Organization.new
    end

    def create
      @organization = Organization.create(organization_params)
      @organizations = Organization.all
    end

    def edit
    end

    def update
      @organization.update_attributes(organization_params)
      @organizations = Organization.all
    end

    private

    def organization_params
      params.require(:organization).permit(:name, :role, :active, :access_id, :secret_key)
    end

    def load_resource
      @organization = Organization.find(params[:id])
    end
  end
end