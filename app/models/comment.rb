class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post

  validates_associated :author
  validates_associated :post

  validates :text, presence: true, length: { minimum: 1 }

  def increment_post_comments_counter
    post.increment!(:comment_counter)
  end

  def decrement_post_comments_counter
    post.decrement!(:comment_counter) unless post.comment_counter.zero?
  end
end
