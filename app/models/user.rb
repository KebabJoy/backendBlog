class User < ActiveRecord::Base
  has_many :questions, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :purchases

  validate :password_validness

  def password_validness
    unless password == password_confirmation
      errors.add(:password, 'Passwords must be equal')
    end

    if password.size < 6
      errors.add(:password, 'Password must contain at least 6 characters')
    end

    errors.empty?
  end
end
