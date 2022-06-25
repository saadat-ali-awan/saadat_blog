class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :comments
  has_many :posts
  has_many :likes

  validates :name, presence: true, length: { minimum: 1 }
  validates :post_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  ROLES = %i[admin default].freeze

  def is?(requested_role)
    role == requested_role.to_s
  end

  def self.three_most_recent_posts(user)
    Post.where(user_id: user.id).order(created_at: :desc).limit(3)
  end
end
