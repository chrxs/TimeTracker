module Api::V1
  class ApiController < ApplicationController
    # Generic API stuff here

    rescue_from CanCan::AccessDenied do |exception|
      head :forbidden
    end

  end
end
