module Cognizant
  class RelocationsController < ApplicationController

    # CanCanCommunity - automatically authorize all actions in a RESTful style resource controller
    load_and_authorize_resource

    before_action :check_relocation_state, only: [:dashboard]

    def show

    end

    def edit

    end

    def update

    end

    def dashboard

    end

    private

    def check_relocation_state
      redirect_to welcome_wizard_path and return if @relocation.initiated?
    end

    def welcome_wizard_path
      cognizant_relocation_step_path(@relocation, "welcome")
    end

    def relocation_params
      params.require(:relocation).permit(:origin_metro_area_id, :destination_metro_area_id)
    end
  end
end
