require 'rails_helper'

describe 'Users Controller' do
  it 'open homepage' do
    get '/'
    expect(response).to have_http_status(200)
    expect(response).to render_template('index')
    expect(response.body).to include('Hello! This is All Users List...')
  end

  it 'open user detail' do
    get '/users/12'
    expect(response).to have_http_status(200)
    expect(response).to render_template('show')
    expect(response.body).to include('Show A User...')
  end
end
