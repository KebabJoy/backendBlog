# frozen_string_literal: true

class CommentSerializer < ActiveModel::Serializer
  attributes :body, :author_name

  def author_name
    object.author.name
  end
end