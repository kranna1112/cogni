module Api
  module Cognizant
    module V1
      class RelocationsController < API::ApiController

        # def index
        #   @relocations = Relocations.where()
        # end

        def show
          @relocation = Relocation.includes(:employee, :organization, :agency).find(params[:id])
        end

        def create
          organization = Organization.find_by_name "Cognizant"
          relocation = organization.relocations.new(relocation_params)
          relocation = relocation.create! params
          render json: relocation.to_json
        end



        private

        def relocation_params
          params.require(:relocation).permit(:employee_id, :organization_id, :policy_id, :agency_id, :start_at, :end_at, :budget_cents, :budget_currency,
                                       :status, :origin_metro_area_id, :destination_metro_area_id, :property_values)
        end
      end
    end
  end
end
