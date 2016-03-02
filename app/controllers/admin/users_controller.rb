module Admin
  class UsersController < Admin::BaseController

    before_action :load_resource, only: [:edit, :update, :show]

    def index
      @users = User.all
    end

    # GET /organizations/:id/users/new
    # GET /users/new
    def new
      @user = User.new
      @companies = Organization.where(active: true).order(:name)
    end

    # POST /users
    # POST /users.json
    def create
      # if user already exists in the database we are just creating a new agency relationship
      if User.where(email: params[:user][:email]).exists?
        @user = User.where(email: params[:user][:email]).first
        unless @user.member_of?(params[:user][:company_id])
          @user.memberships.build(organization_id: params[:user][:company_id], role: params[:user][:role], active: true,
                                  can_access_finance: params[:user][:finance], can_access_legal: params[:user][:legal])
          @user.updated_at = Time.now
        end
      else
        @user = User.new(user_params)
        @user.password = Devise.friendly_token.first(8)
        @user.skip_confirmation!
        # will delegated to user.membership
        @user.role = params[:user][:role] || 'worker'
        @user.organization_id = params[:user][:company_id]
        @user.can_access_finance = params[:user][:finance]
        @user.can_access_legal = params[:user][:legal]
        @user.active = true
        @user.default = true
      end

      if @user.changed?
        if @user.save
          @user.notify_organization_access!(@user.organization)
        end
        render :create
      else
        respond_to do |format|
          format.html { redirect_to admin_users_path, notice: 'User already belongs to the organization.'}
        end
      end
    end

    def edit
      @companies = Organization.where(active: true).order(:name)
    end

    def update
      @user.update_attributes(user_params)
      @users = User.all
    end

    # GET /users/1
    def show
    end

    # DELETE /user
    def delete
      @user.soft_delete
    end

    def memberships
      @memberships = Membership.joins(:user).where(user_id: @user.id)
    end

    private

    def user_params
      params.require(:user).permit(:email, :user_name, :first_name, :last_name, :company_id, :role, :finance, :legal, :super_admin)
    end

    def load_resource
      @user = User.find(params[:id])
    end

  end
end