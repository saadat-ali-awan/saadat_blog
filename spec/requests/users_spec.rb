require 'rails_helper'

describe 'Users Controller' do
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
  it 'open homepage' do
    get '/'
    expect(response).to have_http_status(200)
    expect(response).to render_template('index')
    expect(response.body).to include('Saadat')
  end

  it 'open user detail' do
    get "/users/#{@user.id}"
    expect(response).to have_http_status(200)
    expect(response).to render_template('show')
    expect(response.body).to include("Number of posts: #{@user.post_counter}")
  end
end
