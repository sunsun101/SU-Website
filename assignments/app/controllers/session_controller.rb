class SessionController < ApplicationController
  def omniauth
    binding.pry
  end

  private

  def auth
    request.env["omniauth.auth"]
  end
end
