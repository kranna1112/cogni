class Organizations::RelationshipsController < ApplicationController
  # CanCanCommunity - automatically authorize all actions in a RESTful style resource controller
  load_and_authorize_resource :organization
  load_and_authorize_resource :relationship, :through => :organization

  # GET /organizations/:id/relationships
  def index
  end

end