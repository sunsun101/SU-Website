class OmniauthController < ApplicationController
  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signinig in later'
    redirect_to new_user_registration_url
  end

  def google_oauth2
    # binding.pry
    @user = User.create_from_google_data(request.env['omniauth.auth'])
    if @user.persisted?
      p 'signed in'
      sign_in_and_redirect @user
    else
      p 'redirect'
      flash[:error] = 'There was a problem signing in through Google. Please register or try signing in later.'
      redirect_to new_user_registration_url
    end
  end
end