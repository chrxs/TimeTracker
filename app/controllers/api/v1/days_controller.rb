module Api::V1
  class DaysController < ApiController
    before_action :set_user

    # GET /days
    def index
      if !params[:day].blank? && !params[:month].blank? && !params[:year].blank?
        date = Date.parse("#{ params[:year] }-#{ params[:month] }-#{ params[:day] }")
        @days = @user.days.where(date: date)
      elsif params[:day].blank? && !params[:month].blank? && !params[:year].blank?
        min_date = Date.parse("#{ params[:year] }-#{ params[:month] }-01")
        max_date = min_date.end_of_month
        @days = @user.days.where(date: min_date...max_date)
      elsif params[:day].blank? && !params[:month].blank? && !params[:year].blank?
        min_date = Date.parse("#{ params[:year] }-01-01")
        max_date = min_date.end_of_year
        @days = @user.days.where(date: min_date...max_date)
      else
        @days = @user.days
      end
      render json: @days
    end

    # POST /days
    def create
      date = "#{ params[:year] }-#{ params[:month] }-#{ params[:day] }"
      @day = @user.days.where({ date: date }).first_or_create
      if @day.update(day_params)
        render json: @day
      else
        render json: @day.errors, status: :unprocessable_entity
      end
    end


    private
      def set_user
        @user = params[:user_id] ? User.accessible_by(current_ability).find(params[:user_id]) : current_user
      end

      # Only allow a trusted parameter "white list" through.
      def day_params
        params.permit(
          time_records: [
            :id,
            :project_id,
            :amount,
            :_destroy,
          ]
        ).tap do |params|
          if params.key?(:time_records)
            params[:time_records_attributes] = params.delete(:time_records)
          end
        end
      end
  end
end
