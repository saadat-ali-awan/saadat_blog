class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  validates_associated :post
  validates_associated :author

  def increment_post_likes_counter
    post.increment!(:like_counter)
  end

  def decrement_post_likes_counter
    unless post.like_counter.zero?
      post.decrement!(:like_counter)
    end
  end
end
