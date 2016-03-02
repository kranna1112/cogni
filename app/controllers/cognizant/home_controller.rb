module Cognizant
  class HomeController < ApplicationController
    skip_before_action :authenticate_user!, :only => [:index]
    skip_authorization_check :only => [:index]
    # authorize_resource :only => [:dashboard, :initiate], :class => false

    def index

    end

  end
end