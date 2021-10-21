class ApplicationController < ActionController::Base
  before_action :current_uri

  def current_uri
    @url = request.original_url
  end
end
