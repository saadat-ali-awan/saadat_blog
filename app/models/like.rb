class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  validates_associated :post
  validates_associated :author

  after_save :increment_post_likes_counter

  after_destroy :decrement_post_likes_counter

  def increment_post_likes_counter
    post.increment!(:like_counter)
  end

  def decrement_post_likes_counter
    post.decrement!(:like_counter) unless post.like_counter.zero?
  end
end
