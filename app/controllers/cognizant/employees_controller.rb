module Cognizant
  class EmployeesController < ApplicationController

    # CanCanCommunity - automatically authorize all actions in a RESTful style resource controller
    load_and_authorize_resource

    def edit

    end

    def update

    end

    private

    def employee_params
      params.require(:employee).permit(:first_name, :middle_name, :last_name)
    end

  end
end