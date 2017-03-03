module Api::V1
  class UsersController < ApiController
    load_and_authorize_resource

    def index
      render json: @users
    end

    def show
      render json: @user
    end

    def myself
      render json: current_user
    end

  end
end
