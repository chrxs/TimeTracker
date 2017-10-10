module Api::V1
  class SlackController < ApiController
    skip_before_action :authenticate_request


    def trigger
      client = Slack::Web::Client.new
      client.auth_test
      response = client.chat_postMessage(
        channel: "U257X2CP3",
        text: "⁠⁠⁠Which project did you work on today?",
        username: "TimeBot",
        as_user: false,
        response_type: "in_channel",
        attachments: [
          {
            text: "THURSDAY, MAY 25",
            fallback: "You are unable to enter time",
            callback_id: "project_id",
            color: "#3AA3E3",
            attachment_type: "default",
            actions: [
              {
                name: "project_list",
                text: "Select project...",
                type: "select",
                options: Project.all.map { |p| { text: p.name, value: p.id } }
              },
              {
                name: "time",
                text: "Select time...",
                type: "select",
                options: [
                  {
                    text: "8 hours",
                    value: "480"
                  },
                  {
                    text: "4 hours",
                    value: "240"
                  }
                ],
                selected_options: [
                  {
                    text: "8 hours",
                    value: "480"
                  }
                ]
              }
            ]
          }
        ]
      )
      render json: response
    end

  end
end
