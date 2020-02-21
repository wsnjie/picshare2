class PicsController < ApplicationController
  skip_before_action :verify_authenticity_token
  #skip_before_filter :authenticate_user!, :only => "reply"

  def index
    render json: Pic.all
  end
end