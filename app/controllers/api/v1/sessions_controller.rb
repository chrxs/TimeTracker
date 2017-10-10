module Api::V1
  class SessionsController < ApiController
    skip_before_action :authenticate_request

    def create
      info, access_token = Omniauth::Slack.authenticate(
        params["code"],
        params["redirect_uri"]
      )

      user = User.from_omniauth!(info, access_token)
      user.team = Team.from_omniauth!(info, access_token)

      token = JsonWebToken.encode(
        user: UserSerializer.new(user).as_json
      )

      response.headers["Authorization"] = token
      render json: user, status: 200
    end
  end
end
