module Api::V1
  class ProjectsController < ApiController
    load_and_authorize_resource :client
    load_and_authorize_resource :project, through: :client, shallow: true

    # GET /projects
    def index
      render json: @projects
    end

    # GET /projects/1
    def show
      render json: @project
    end

    # POST /projects
    def create
      @project = Project.new(project_params)

      if @project.save
        render json: @project, status: :created
      else
        render json: @project.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /projects/1
    def update
      if @project.update(project_params)
        render json: @project
      else
        render json: @project.errors, status: :unprocessable_entity
      end
    end

    # DELETE /projects/1
    def destroy
      @project.destroy
    end

    private
      # Only allow a trusted parameter "white list" through.
      def project_params
        params.permit(:name)
      end
  end
end
