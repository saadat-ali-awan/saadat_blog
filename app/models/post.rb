class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  validates_associated :author

  validates :title, presence: true, length: { in: 1..250 }
  validates :text, presence: true, length: { in: 1..250 }
  validates :comment_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :like_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_destroy :decrement_user_post_counter

  def increment_user_post_counter
    author.increment!(:post_counter)
  end

  def decrement_user_post_counter
    author.decrement!(:post_counter) unless author.post_counter.zero?
  end
end
