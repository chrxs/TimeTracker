module Api::V1
  class DaysController < ApiController
    before_action :set_day, only: [:show, :update, :destroy]

    # GET /days
    def index
      @days = Day.all

      render json: @days
    end

    # GET /days/1
    def show
      render json: @day
    end

    # POST /days
    def create
      user = User.find(params["user_id"])
      @day = user.days.where({ date: day_params[:date] }).first_or_create
      if @day.update(day_params)
        render json: @day, status: :created
      else
        render json: @day.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /days/1
    def update
      if @day.update(day_params)
        render json: @day
      else
        render json: @day.errors, status: :unprocessable_entity
      end
    end

    # DELETE /days/1
    def destroy
      @day.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_day
        @day = Day.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def day_params
        params.permit(
          :date,
          time_records: [:project_id, :amount]
        ).tap do |params|
          if params.key?(:time_records)
            params[:time_records_attributes] = params.delete(:time_records)
          end
        end
      end
  end
end
