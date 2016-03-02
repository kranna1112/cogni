class EmployeesController < ApplicationController

  # CanCanCommunity - automatically authorize all actions in a RESTful style resource controller
  load_and_authorize_resource

  def index
    @employees.where(organization_id: params[:organization_id]).order(:last_name) if params[:organization_id].present?
  end

  def show

  end

  def edit

  end

  def update

  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name)
  end
end
