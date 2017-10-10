module Api::V1
  class WeekdaySettingsController < ApiController
    before_action :set_user

    def index
      render json: @user.weekday_settings
    end

    def update_all
      if @user.update(weekday_settings_params)
        render json: @user.weekday_settings
      else
        render json: @user.errors
      end
    end

    private
      def weekday_settings_params
        params.permit(
          weekday_settings: [
            :id,
            :required_minutes_logged,
          ]
        ).tap do |params|
          if params.key?(:weekday_settings)
            params[:weekday_settings_attributes] = params.delete(:weekday_settings)
          end
        end
      end

  end
end
