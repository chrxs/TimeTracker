class ApplicationController < ActionController::API
  include CanCan::ControllerAdditions
  before_action :authenticate_request

  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    unless @current_user
      render json: { error: 'Not Authorized' }, status: 401
    end
  end
end
