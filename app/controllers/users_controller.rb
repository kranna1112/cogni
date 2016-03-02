class UsersController < ApplicationController

  # CanCanCommunity - automatically authorize all actions in a RESTful style resource controller
  load_and_authorize_resource

  def index
    @users.where(company_id: params[:organization_id]).order(:last_name) if params[:organization_id].present?
  end

  # switch organization
  # PUT /users/switch?organization_id=2
  def switch
    # check if user can switch to the organization
    if current_user.member_of?(params[:organization_id])
      if current_user.current.organization_id != params[:organization_id].to_i
        membership = Membership.where(organization_id: params[:organization_id], user_id: current_user).first
        # update enabled as false
        current_user.current.update(active: false)
        membership.update(active: true)
        session[:organization_id] = current_user.current.organization_id
      end
    else
      flash[:error] = "You can't switch to the organization"
    end

    redirect_to dashboard_organization_path(params[:organization_id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :user_name, :first_name, :last_name, :company_id, :role, :finance, :legal)
  end
end