# frozen_string_literal: true

module Api
  module V1
    module Blog
      class PurchasesController < Api::V1::BaseController

        def index
          @purchases = @current_user.purchases

          render json: { purchases: @purchases, amount_sum: @purchases.sum(:amount) }
        end

        def create
          @question = @current_user.purchases.new(purchase_params)

          if @question.save
            render json: @question
          else
            render json: @question.errors, status: :unprocessable_entity
          end
        end

        private

        def purchase_params
          params.require(:purchase).permit(:title, :amount)
        end
      end
    end
  end
end
