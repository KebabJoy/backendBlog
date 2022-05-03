# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session
      before_action :authenticate_user

      rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing

      def handle_parameter_missing(exception)
        render json: { error: true, message: exception.message.capitalize }, status: 400
      end

      def authenticate_user
        if request.headers['Authorization'].present?
          @current_user = User.find_by(token: request.headers['Authorization'])
        else
          return render json: { error: true, message: 'Unauthorized' }, status: 403
        end

        @current_user
      end
    end
  end
end
