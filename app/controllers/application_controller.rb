class ApplicationController < ActionController::API
  include CanCan::ControllerAdditions
  before_action :authenticate_request

  attr_reader :current_user

  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: "Forbidden" }, status: :forbidden
  end

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    unless @current_user
      render json: { error: "Not Authorized" }, status: :unauthorized
    end
  end
end
