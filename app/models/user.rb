class User < ActiveRecord::Base
  has_many :questions, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
end
