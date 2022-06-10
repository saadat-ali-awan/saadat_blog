require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  it 'when post page found' do
    get '/users/12/posts'
    expect(response).to have_http_status(200)
    expect(response).to render_template('index')
    expect(response.body).to include('Show all posts for a user...')
  end
  it 'when post opened' do
    get '/users/12/posts/13'
    expect(response).to have_http_status(200)
    expect(response).to render_template('show')
    expect(response.body).to include('Show a post for a user...')
  end
end
