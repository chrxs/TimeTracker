module Api::V1
  class ApiController < ApplicationController

    private
      def set_user
        @user = params[:user_id] ? User.accessible_by(current_ability).find(params[:user_id]) : current_user
      end

  end
end
