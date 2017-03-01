module Api::V1
  class DaysController < ApiController
    before_action :set_day, only: [:show, :update, :destroy]

    # GET /days
    def index
      if !params[:day].blank? && !params[:month].blank? && !params[:year].blank?
        date = Date.parse("#{ params[:year] }-#{ params[:month] }-#{ params[:day] }")
        @days = current_user.days.where(date: date)
      elsif params[:day].blank? && !params[:month].blank? && !params[:year].blank?
        min_date = Date.parse("#{ params[:year] }-#{ params[:month] }-01")
        max_date = min_date.end_of_month
        @days = current_user.days.where(date: min_date...max_date)
      elsif params[:day].blank? && !params[:month].blank? && !params[:year].blank?
        min_date = Date.parse("#{ params[:year] }-01-01")
        max_date = min_date.end_of_year
        @days = current_user.days.where(date: min_date...max_date)
      else
        @days = current_user.days
      end
      render json: @days
    end

    # GET /days/1
    def show
      render json: @day
    end

    # POST /days
    def create
      date = "#{ params[:year] }-#{ params[:month] }-#{ params[:day] }"
      @day = current_user.days.where({ date: date }).first_or_create
      if @day.update(day_params)
        render json: @day, status: :created
      else
        render json: @day.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /days/1
    # def update
    #   if @day.update(day_params)
    #     render json: @day
    #   else
    #     render json: @day.errors, status: :unprocessable_entity
    #   end
    # end

    # DELETE /days/1
    def destroy
      @day.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_day
        @day = current_user.days.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def day_params
        params.permit(
          :_destroy,
          time_records: [:id, :project_id, :amount]
        ).tap do |params|
          if params.key?(:time_records)
            params[:time_records_attributes] = params.delete(:time_records)
          end
        end
      end
  end
end
