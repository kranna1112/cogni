module Cognizant
  class StepsController < ApplicationController

    load_and_authorize_resource :relocation

    before_action :check_relocation_state, only: [:show, :update]

    include Wicked::Wizard

    skip_authorization_check

    steps :welcome, :confirm, :services, :final, :finish

    def show
      @employee = @relocation.employee
      case step
        when :welcome
        when :confirm
        when :services
          @services = @relocation.relocation_benefits
        when :final
        when :finish
          redirect_to finish_wizard_path and return
      end
      render_wizard
    end

    def update
      case step
        when :welcome
        when :confirm
        when :services
        when :final
        when :finish
          @relocation.onboard! if @relocation.initiated?
          redirect_to finish_wizard_path and return
      end
      render_wizard
    end

    private

    def finish_wizard_path
      dashboard_cognizant_relocation_path(@relocation)
    end

    def check_relocation_state
      redirect_to finish_wizard_path and return if @relocation.onboarded?
    end

    def employee_params
      params.require(:employee).permit(:first_name, :middle_name, :last_name)
    end
  end
end