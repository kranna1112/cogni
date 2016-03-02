class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]
  skip_authorization_check :only => [:index]
  authorize_resource :only => [:dashboard], :class => false

  def index

  end

  def dashboard

  end

  def employee_home

  end
end