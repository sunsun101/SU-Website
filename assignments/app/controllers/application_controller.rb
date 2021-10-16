class ApplicationController < ActionController::Base
  before_action :current_uri
  #   skip_before_action :verify_authenticity_token

  def current_uri
    @url = request.original_url
  end
end
