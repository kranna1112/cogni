class Organizations::MembershipsController < ApplicationController
  # CanCanCommunity - automatically authorize all actions in a RESTful style resource controller
  load_and_authorize_resource :organization
  load_and_authorize_resource :membership, :through => :organization

  # GET /organizations/:id/memberships
  def index
  end

  def edit
  end

  def update
    @membership.update_attributes(membership_params)
    @memberships = @organization.memberships
  end

  def new
    @membership = @organization.memberships.build
    # Get the orgs where current_user is an admin and the membership is active
    current_orgs = current_user.memberships.where(role: 'admin', active: true)
    # Build array of
    org_ids = current_orgs.map(&:organization_id)
    @users = User.where(company_id: org_ids)
  end

  def create
    @membership = @organization.memberships.create(membership_params)
    @memberships = @organization.memberships
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :active, :can_access_finance, :can_access_legal, :role)
  end

end