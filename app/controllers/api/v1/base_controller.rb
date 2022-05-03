# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session

      rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing

      def handle_parameter_missing(exception)
        render json: { error: true, message: exception.message.capitalize }, status: 400
      end
    end
  end
end
