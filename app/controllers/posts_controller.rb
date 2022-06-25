require_relative './modules/form_error_handler'
class PostsController < ApplicationController
  load_and_authorize_resource
  include FormErrorHandler

  def index
    index = params['user_id']
    @user = User.find(index)
    @posts = Post.where(user_id: @user.id).includes(comments: [:author])
  end

  def show
    user_id = params['user_id']
    @user = User.find(user_id)
    post_id = params['id']
    @post = Post.includes(comments: [:author]).find(post_id)
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
    errors << 'Title Missing From Post' if params[:post][:title] == ''
    errors << 'Text Missing From Post' if params[:post][:text] == ''
    found_errors = validate_form(errors)

    respond_to do |format|
      format.html do
        unless found_errors
          new_post.author = current_user
          if new_post.save
            new_post.increment_user_post_counter
            flash[:success] = ['Post Created Successfully']
            redirect_to posts_url
            return
          end
          flash.now[:danger] = ['Post could not be saved']
        end
        render :new, locals: { post: new_post }, status: 422
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    authorize! :destroy, @post
    @comment = @post.comments
    @comment.each(&:destroy)
    @post.destroy
    flash[:success] = ['Post Deleted Successfully']

    respond_to do |format|
      format.html { redirect_to "/users/#{current_user.id}/posts" }
      format.json { head :no_content }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
