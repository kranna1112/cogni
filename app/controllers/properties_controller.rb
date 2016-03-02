class PropertiesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @properties = Property.where(entity_type: params[:entity_type])

    @bundles_enabled = params[:entity_type].constantize.enable_bundles

    if @bundles_enabled
      @bundles = Bundle.where(entity_type: params[:entity_type]).includes(:properties)
    end
  end

  def create
    @property = Property.new(property_params)

    unless @property.save
      render json: { success: false, message: @property.errors.full_messages.join('. ') }
    end

    # expire_fragment("properties")
    expire_fragment("properties:#{Tenant.current_tenant_id}")
  end

  def destroy
    @property = Property.find(params[:id])

    @property.destroy

    # expire_fragment("properties")
    expire_fragment("properties:#{Tenant.current_tenant_id}")

    render json: { success: true }
  end

  def update
    @property = Property.find(params[:id])

    unless @property.update(property_params)
      render json: { success: false, message: @property.errors.full_messages.join('. ') }
    end

    # expire_fragment("properties")
    expire_fragment("properties:#{Tenant.current_tenant_id}")
  end

  private

  def property_params
    params.require(:property).permit(:entity_type, :value_type, :name, :default_value, :choices => [])
  end
end
