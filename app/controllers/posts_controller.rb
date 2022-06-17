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

  def new
    post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: post } }
    end
  end

  def create
    new_post = Post.new(post_params)
    errors = []
    errors << "Title Missing From Post" if params[:post][:title] == ''
    errors << "Text Missing From Post" if params[:post][:text] == ''
    unless errors.length.zero?
      errors.each do |error|
        if flash.now[:danger].nil?
          flash.now[:danger] = [ error ]
        else
          flash.now[:danger] << error
        end
      end
      respond_to do |format|
        format.html do
          render :new, locals: {post: new_post}, status: 422
        end
      end
      
      return
    end
    new_post.author = current_user
    respond_to do |format|
      format.html do
        if new_post.save
          new_post.increment_user_post_counter
          flash[:success] = [ "Post Created Successfully" ]
          redirect_to posts_url
        else
          flash.now[:danger] = [ "Error: Post could not be saved" ]
          render :new, locals: {post: new_post}, status: 422
        end
      end
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
