class User < ApplicationRecord
  has_many :comments
  has_many :posts
  has_many :likes
  
  def self.three_most_recent_posts
    Post.where(user: self).order(created_at: :desc).limit(3)
  end
end