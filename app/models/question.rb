class Question < ActiveRecord::Base
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments

  validates :title, :body, presence: true, length: { minimum: 5 }
end
