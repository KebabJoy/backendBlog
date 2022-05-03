# frozen_string_literal: true

module Api
  module V1
    module Blog
      class CommentsController < Api::V1::BaseController
        before_action :set_question

        def index
          @comments = @question.comments

          render json: @comments
        end

        def create
          @comment = @question.comments.new(comment_params.merge(author: @current_user))

          if @comment.save
            render json: @comment, status: :created
          else
            render json: { errors: @comment.errors }, status: :unprocessable_entity
          end
        end

        private

        def set_question
          @question = Question.find(params[:question_id])
        end

        def comment_params
          params.require(:comment).permit(:body)
        end
      end
    end
  end
end