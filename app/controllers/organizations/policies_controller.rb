class Organizations::PoliciesController < ApplicationController

  # CanCanCommunity - automatically authorize all actions in a RESTful style resource controller
  load_and_authorize_resource :organization, only: [:index, :new, :create]
  load_and_authorize_resource :policy, :through => :organization, only: [:index, :new, :create]

  load_and_authorize_resource :policy, only: [:edit, :update, :show]
  load_and_authorize_resource :organization, :through => :policy, only: [:edit, :update, :show]

  # GET /organizations/:id/policies
  def index
  end

  def new
    @policy = @organization.policies.build
  end

  def create
    @policy = @organization.policies.create(policy_params)
    @policies = @organization.reload.policies
  end

  def edit
  end

  def update
    @policy.update_attributes(policy_params) if @policy.draft?
    @policies = @policy.organization.policies
  end

  def show
  end

  private

  def policy_params
    params.require(:policy).permit(:name, :description, :status, :start_at, :end_at, policy_benefits_attributes: [:id, :name, :description, :service_type_id])
  end

end