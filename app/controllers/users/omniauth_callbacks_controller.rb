class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :authenticate_request

  def google_oauth2
    @user = User.from_omniauth!(request.env["omniauth.auth"])
    sign_in @user
    response.headers['Authorization'] = JsonWebToken.encode(user_id: @user.id)
    render json: { user: @user }, status: 200
  end
end
