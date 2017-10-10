module Api::V1
  class DaysController < ApiController
    before_action :set_user

    # GET /days
    def index
      date_range = get_date_range
      if date_range
        render json: @user.days.where(date: date_range)
      else
        render json: @user.days
      end
    end

    def show
      render json: @user.days.where(date: get_date).first
    end

    # POST /days
    def create_or_update
      @day = @user.days.where({ date: get_date }).first_or_create

      # Remove missing time_records
      existing_ids = @day.time_records.pluck(:id)
      update_ids = params[:time_records].pluck(:id).compact
      remove_ids = existing_ids - update_ids
      @day.time_records.where(id: remove_ids).destroy_all

      if @day.update(day_params)
        render json: @day
      else
        render json: @day.errors, status: :unprocessable_entity
      end
    end


    private
      def get_date_range
        date_range = nil
        start_date = nil
        end_date = nil
        if params[:start]
          start_date = Date.parse(params[:start])
          end_date = params[:end] ? Date.parse(params[:end]) : Date.today
        elsif params[:end]
          start_date = params[:start] ? Date.parse(params[:start]) : Date.today
          end_date = Date.parse(params[:end])
        end
        if start_date && end_date
          if start_date > end_date
            date_range = end_date..start_date
          else
            date_range = start_date..end_date
          end
        end
        date_range
      end

      def get_date
        date_parts = params.slice(:year, :month, :day).values()
        date_parts << Date.today.year if date_parts.empty?
        date_parts.fill("01", date_parts.size, 3 - date_parts.size)
        Date.parse(date_parts.join("-"))
      end

      # Only allow a trusted parameter "white list" through.
      def day_params
        params.permit(
          time_records: [
            :id,
            :project_id,
            :amount,
          ]
        ).tap do |params|
          if params.key?(:time_records)
            params[:time_records_attributes] = params.delete(:time_records)
          end
        end
      end
  end
end
