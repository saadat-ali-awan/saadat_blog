class UsersController < ApplicationController
  def initialize
    super
    @users = []
  end

  def index
    @users = User.all
  end

  def show
    index = params['id'].to_i
    @user_info = User.find(index)
    @posts = User.three_most_recent_posts(@user_info)
  end
end
