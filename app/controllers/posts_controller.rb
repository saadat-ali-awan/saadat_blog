class PostsController < ApplicationController
  def index
    index = params['user_id']
    @user = User.find(index)
    @posts = Post.where(user_id: @user.id)
  end

  def show
    user_id = params['user_id']
    @user = User.find(user_id)
    post_id = params['id']
    @post = Post.find(post_id)
  end
end
