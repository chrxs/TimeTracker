module Api::V1
  class ClientsController < ApiController
    load_and_authorize_resource

    # GET /clients
    def index
      render json: @clients
    end

    # GET /clients/1
    def show
      render json: @client
    end

    # POST /clients
    def create
      @client = Client.new(client_params)
      @client.team = current_user.team

      if @client.save
        render json: @client, status: :created
      else
        render json: @client.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /clients/1
    def update
      if @client.update(client_params)
        render json: @client
      else
        render json: @client.errors, status: :unprocessable_entity
      end
    end

    # DELETE /clients/1
    def destroy
      @client.destroy
    end

    private
      # Only allow a trusted parameter "white list" through.
      def client_params
        params.permit(
          :id,
          :name,
          projects: [
            :id,
            :name
          ]
        ).tap do |params|
          if params.key?(:projects)
            params[:projects_attributes] = params.delete(:projects)
          end
        end
      end
  end
end
