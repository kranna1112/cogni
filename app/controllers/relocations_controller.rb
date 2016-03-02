class RelocationsController < ApplicationController

  # CanCanCommunity - automatically authorize all actions in a RESTful style resource controller
  load_and_authorize_resource

  def index
  end

  def show

  end

  def edit
  end

  def update
  end

  private

  def relocation_params
    params.require(:relocation).permit(:employee_id, :organization_id, :policy_id, :agency_id, :start_at, :end_at, :budget,
                                    :status, :origin_metro_area_id, :destination_metro_area_id )
  end

end
