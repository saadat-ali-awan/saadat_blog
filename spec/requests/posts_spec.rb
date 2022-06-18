require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  before :all do
    @user = User.create(
      name: 'Saadat',
      post_counter: 3
    )
    @post = Post.create(
      title: 'My Title',
      text: 'My Testing Post',
      comment_counter: 12,
      like_counter: 12,
      author: @user
    ) 
  end
  it 'when post page found' do
    get "/users/#{@user.id}/posts"
    expect(response).to have_http_status(200)
    expect(response).to render_template('index')
    expect(response.body).to include("Post ##{@post.id}")
  end
  it 'when post opened' do
    get "/users/#{@user.id}/posts/#{@post.id}"
    expect(response).to have_http_status(200)
    expect(response).to render_template('show')
    expect(response.body).to include("Post ##{@post.id} #{@user.name}")
  end
end
