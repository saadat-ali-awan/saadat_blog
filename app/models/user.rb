class User < ApplicationRecord
  has_many :comments
  has_many :posts
  has_many :likes

  validates :name, presence: true, length: { minimum: 1 }
  validates :post_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}

  def self.three_most_recent_posts(user)
    Post.where(user_id: user.id).order(created_at: :desc).limit(3)
  end
end
