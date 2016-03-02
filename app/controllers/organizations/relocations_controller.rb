class Organizations::RelocationsController < ApplicationController

  # CanCanCommunity - automatically authorize all actions in a RESTful style resource controller
  load_and_authorize_resource :organization
  load_and_authorize_resource :relocation, :through => :organization

  def index
  end

  def new
    @relocation = Relocation.new
  end

  def create
    @relocation = @organization.relocations.new(relocation_params)
    @relocation = @relocation.create! params
    @relocations = Relocation.where(organization: @organization)
  end

  private

  def relocation_params
    params.require(:relocation).permit(:employee_id, :organization_id, :policy_id, :agency_id, :start_at, :end_at, :budget_cents, :budget_currency,
                                       :status, :origin_metro_area_id, :destination_metro_area_id, :property_values)
  end
end
