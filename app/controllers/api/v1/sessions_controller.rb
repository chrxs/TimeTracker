module Api::V1
  class SessionsController < ApiController
    skip_before_action :authenticate_request

    def create
      info, access_token = Omniauth::Slack.authenticate(
        params["code"],
        params["redirect_uri"]
      )
      @user = User.from_omniauth!(info)
      response.headers["Authorization"] = JsonWebToken.encode(
        user: UserSerializer.new(@user).as_json
      )
      render json: @user, status: 200
    end
  end
end
