class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  def increment_user_post_counter
    user.increment!(:post_counter)
  end

  def decrement_user_post_counter
    user.decrement!(:post_counter)
  end
end
