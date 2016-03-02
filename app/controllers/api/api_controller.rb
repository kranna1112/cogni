class API::ApiController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  respond_to :json

  # acts_as_token_authentication_handler_for User, fallback: exception

  # before_action :set_current_membership, :if => :current_user

  # helper_method :current_membership

  # def set_current_membership
  #   if user_signed_in?
  #     # set default tenant to use
  #
  #     @current_membership = current_user.current
  #   end
  # end

  # def current_membership
  #   @current_membership ||= current_user.current
  # end


  #Handle RecordNotFound errors https://github.com/emilsoman/rails-4-api/blob/master/app/controllers/application_controller.rb
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: {errors: [exception.message]}, status: :unprocessable_entity
  end

end