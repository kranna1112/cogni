module Admin
  class BaseController < ApplicationController

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    # protect_from_forgery with: :exception

    skip_authorization_check

    # before_filter :authenticate_user!
    before_filter :authorize_super_admin

    # def response_403
    #   respond_to do |format|
    #     format.json { render :json => { success: false, message: "You can't perform the action." } }
    #     format.html { redirect_to root_path, flash: { :error => "You can't access the page." } }
    #   end
    # end

    private
    def authorize_super_admin
      unless current_user.super_admin?
        sign_out(current_user)
        redirect_to root_url(:subdomain => false)
      end  
    end
  end
end
