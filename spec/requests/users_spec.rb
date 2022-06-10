require 'rails_helper'

describe 'Users Controller' do
  it 'open homepage' do
    get '/'
    expect(response).to have_http_status(200)
    expect(response).to render_template('index')
  end

  it 'open user detail' do
    get '/users/12'
    expect(response).to have_http_status(200)
    expect(response).to render_template('show')
  end
end
