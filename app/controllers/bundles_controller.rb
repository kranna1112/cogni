class BundlesController < ApplicationController
  before_action :authenticate_admin!

  def create
    @bundle = Bundle.new(bundle_params)

    unless @bundle.save
      render json: { success: false, message: @bundle.errors.full_messages.join('. ') }
    end

    # expire_fragment("properties")
    expire_fragment("properties:#{Tenant.current_tenant_id}")
  end

  def destroy
    @bundle = Bundle.find(params[:id])

    @bundle.destroy

    # expire_fragment("properties")
    expire_fragment("properties:#{Tenant.current_tenant_id}")

    render json: { success: true }
  end

  def update
    @bundle = Bundle.find(params[:id])

    unless @bundle.update(bundle_params)
      render json: { success: false, message: @bundle.errors.full_messages.join('. ') }
    end

    # expire_fragment("properties")
    expire_fragment("properties:#{Tenant.current_tenant_id}")
  end

  private

  def bundle_params
    params.require(:bundle).permit(:entity_type, :name, :property_ids => [])
  end
end
