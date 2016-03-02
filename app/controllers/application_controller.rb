class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_filter :subdomain_view_path
  layout :set_layout

  check_authorization :unless => :devise_controller?

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user! # authenticate user
  before_action :current_membership, :if => :current_user

  rescue_from CanCan::AccessDenied do |exception|
    response_403
  end

  def response_403
    respond_to do |format|
      format.json { render :json => { success: false, message: "You can't perform the action." } }
      format.html { redirect_to root_path, flash: { :error => "You can't access the page." } }
    end
  end

  protected

  # def subdomain_view_path
  #   prepend_view_path "app/views/#{request.subdomain}" if request.subdomain.present? && request.subdomain != "www" && request.subdomain != 'admin'
  # end

  def set_layout
    (request.subdomain if request.subdomain.present? && request.subdomain != 'www') || 'application'
  end

  def current_membership
    # set default organization to use
    @current_membership ||= current_user.current.organization
  end

  def after_sign_in_path_for(resource)
    # log every login
    Rails.logger.debug "USER LOGIN: email: #{resource.email} IP: #{resource.current_sign_in_ip}"

    if resource.is_transferee?
      if resource.employee.relocations.active.present?
        # TODO need to ensure only 1 relocation active at a time
        cognizant_relocation_path(resource.employee.relocations.active.first)
      else
        # TODO need to handle other states
        @relocation = resource.employee.relocations.first
        if @relocation.onboarded?
          dashboard_cognizant_relocation_path(@relocation)
        else
          cognizant_relocation_step_path(@relocation, "welcome")
        end
      end
    elsif resource.is_admin?
      dashboard_organization_path(@current_membership)
    else
      root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :user_name, :email, :password, :remember_me) }
  end

end
