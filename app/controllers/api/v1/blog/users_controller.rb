# frozen_string_literal: true

module Api
  module V1
    module Blog
      class UsersController < BaseController
        skip_before_action :authenticate_user

        def sign_in
          @user = User.where(password: login_params[:password], email: login_params[:email]).first

          if @user
            render json: @current_user, status: :ok
          else
            render json: { error: 'Invalid email or password' }, status: :unauthorized
          end
        end

        def create
          @user = User.new(user_params.merge(token: SecureRandom.hex))

          if @user.save
            render json: @user
          else
            render json: @user.errors, status: :unprocessable_entity
          end
        end

        private

        def login_params
          params.require(:user).permit(:email, :password)
        end

        def user_params
          params.require(:user).permit(:name, :email, :password, :password_confirmation).dup.tap do |hash|
            hash[:name] = hash.require(:name)
            hash[:email] = hash.require(:email)
            hash[:password] = hash.require(:password)
            hash[:password_confirmation] = hash.require(:password_confirmation)
          end
        end
      end
    end
  end
end
