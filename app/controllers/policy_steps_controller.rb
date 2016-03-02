class StepsController < ApplicationController

  include Wicked::Wizard

  steps :policy, :lines

  def show

    # case step
    #   when :policy
    #     @policy = Policy.new
    #   when :lines
    #     @
    # end
  end

end