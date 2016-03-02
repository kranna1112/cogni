class Organizations::UsersController < ApplicationController

  # CanCanCommunity - automatically authorize all actions in a RESTful style resource controller
  load_and_authorize_resource :organization
  load_and_authorize_resource :user, :through => :organization

  # GET /organizations/:id/users
  def index
  end

  def new
    @user = @organization.users.build
  end

  # POST /organizations/:id/users
  def create
    # if user already exists in the database we are just creating a new agency relationship
    if User.where(email: params[:user][:email]).exists?
      @user = User.where(email: params[:user][:email]).first
      unless @user.member_of?(params[:organization_id])
        @user.memberships.build(organization_id: params[:organization_id], role: params[:user][:role], active: true,
                                can_access_legal: [:user][:legal], can_access_finance: [:user][:finance])
        @user.updated_at = Time.now
      end
    else
      @user = @organization.users.create(user_params)
      @user.company_id = params[:organization_id]
      @user.password = Devise.friendly_token.first(8)
      @user.skip_confirmation!
      # will delegated to user.membership
      @user.role = params[:user][:role] || 'worker'
      @user.organization_id = params[:organization_id]
      @user.can_access_finance = params[:user][:finance]
      @user.can_access_legal = params[:user][:legal]
      @user.active = true
      @user.default = true

    end

    if @user.changed?
      respond_to do |format|
        if @user.save
          @user.notify_organization_access!(@user.organization)
          format.html { redirect_to users_path, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to users_path, notice: 'User already belongs to the organization.'}
      end
    end
  end

  def edit
    @user_agency = Membership.where(organization_id: @organization.id, user_id: @user.id).first
  end

  def update
    @user.update_attributes(user_params)
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:email, :user_name, :first_name, :last_name, :organization_id, :role, :active, :finance, :legal)
  end

end