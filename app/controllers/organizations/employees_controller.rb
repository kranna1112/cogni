class Organizations::EmployeesController < ApplicationController

  # CanCanCommunity - automatically authorize all actions in a RESTful style resource controller
  load_and_authorize_resource :organization
  load_and_authorize_resource :employee, :through => :organization

  def index
    @employees = Employee.all
  end

  def new
    @employee = @organization.employees.new
  end

  def create
    @employee = @organization.employees.create(employee_params)
    @employees = Employee.all
  end

  private

  def employee_params
    params.require(:employee).permit(:user_id, :first_name, :middle_name, :last_name, :property_values)
  end

end
