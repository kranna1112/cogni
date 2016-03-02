class PoliciesController < ApplicationController
  # CanCanCommunity - automatically authorize all actions in a RESTful style resource controller
  load_and_authorize_resource

  def index

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  private

  def policy_params
    params.require(:policy).permit(:name, :description, :status, :content, :start_at, :end_at)
  end

end