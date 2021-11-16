require 'test_helper'

class OmniauthControllerTest < ActionDispatch::IntegrationTest
  def valid_google_oauth2_login_setup
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
                                                                         provider: 'google_oauth2',
                                                                         uid: '123545',
                                                                         info: {
                                                                           first_name: 'Gaius',
                                                                           last_name: 'Baltar',
                                                                           email: 'test@ait.asia'
                                                                         },
                                                                         credentials: {
                                                                           token: '123456',
                                                                           expires_at: Time.now + 1.week
                                                                         },
                                                                         extra: {
                                                                           raw_info: {
                                                                             gender: 'male'
                                                                           }
                                                                         }
                                                                       })
  end

  def invalid_google_oauth2_login_setup
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
                                                                         provider: 'google_oauth2',
                                                                         uid: '123545',
                                                                         info: {
                                                                           first_name: 'Gaius',
                                                                           last_name: 'Baltar',
                                                                           email: nil
                                                                         },
                                                                         credentials: {
                                                                           token: '123456',
                                                                           expires_at: Time.now + 1.week
                                                                         },
                                                                         extra: {
                                                                           raw_info: {
                                                                             gender: 'male'
                                                                           }
                                                                         }
                                                                       })
  end

  # test 'should get failure' do
  #   OmniAuth.config.test_mode = true
  #   get user_google_oauth2_omniauth_callback_url
  #   OmniAuth.config.on_failure = OmniAuth.config.mock_auth[:failure]
  # end

  test 'should get authorize omniauth' do
    valid_google_oauth2_login_setup
    get user_google_oauth2_omniauth_callback_url
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  test 'should not authorize omniauth' do
    invalid_google_oauth2_login_setup
    get user_google_oauth2_omniauth_callback_url
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end
end
