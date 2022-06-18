class LikesController < ApplicationController
  def like
    new_like = Like.new
    new_like.author = current_user
    new_like.post = Post.find(params[:id])
    new_like.post.increment!(:like_counter) if new_like.save
    redirect_to user_post_path(user_id: params[:user_id], id: params[:id])
  end
end
