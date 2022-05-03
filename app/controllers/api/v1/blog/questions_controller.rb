# frozen_string_literal: true

module Api
  module V1
    module Blog
      class QuestionsController < Api::V1::BaseController
        def index
          @questions = Question.all

          render json: @questions
        end

        def show
          @question = Question.find(params[:id])

          render json: @question
        end

        def create
          @question = @current_user.questions.new(question_params)

          if @question.save
            render json: @question
          else
            render json: @question.errors, status: :unprocessable_entity
          end
        end

        private

        def question_params
          params.require(:question).permit(:title, :body)
        end
      end
    end
  end
end
