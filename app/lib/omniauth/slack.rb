require "httparty"

module Omniauth
  class Slack
    include HTTParty

    base_uri "https://slack.com/api"

    def self.authenticate(code, redirect_uri)
      provider = self.new
      access_token = provider.get_access_token(code, redirect_uri)
      info = provider.get_info(access_token)
      return info, access_token
    end

    def get_access_token(code, redirect_uri)
      response = self.class.get("/oauth.access", query(code, redirect_uri))
      unless response.success?
        Rails.logger.error "Omniauth::Slack.get_access_token Failed"
        fail Omniauth::ResponseError, "errors.auth.slack.access_token"
      end
      response.parsed_response["access_token"]
    end

    def get_info(access_token)
      options = { query: { token: access_token } }
      response = self.class.get("/users.identity", options)
      unless response.success?
        Rails.logger.error "Omniauth::Slack.get_info Failed"
        fail Omniauth::ResponseError, "errors.auth.slack.info"
      end
      response.parsed_response
    end

    private

    def query(code, redirect_uri)
      {
        query: {
          code: code,
          redirect_uri: redirect_uri,
          client_id: ENV["SLACK_CLIENT_ID"],
          client_secret: ENV["SLACK_CLIENT_SECRET"]
        }
      }
    end
  end
end
