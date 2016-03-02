class OrganizationsController < ApplicationController

  # CanCanCommunity - automatically authorize all actions in a RESTful style resource controller
  load_and_authorize_resource

  def show
  end

  def dashboard

  end

  private

  def organization_params
    params.require(:organization).permit(:name, :role, :active)
  end

end