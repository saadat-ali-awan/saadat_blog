require 'rails_helper'

RSpec.describe "Login Page", type: :system do
  before :all do
    @first_user ||= User.create(
      name: 'Tom',
      photo: 'https://live.staticflickr.com/65535/52122569383_698a119861_z.jpg',
      bio: 'A teacher from Mexico',
      email: 'saadatali0202@gmail.com',
      password: '123456',
      created_at: '2022-06-15 01:40:30.027196000 +0000',
      confirmed_at: '2022-06-14 21:22:04.937699'
    )
  end
  describe 'Login Page' do
    it 'shows the right content' do
      visit new_user_session_path
      expect(page).to have_content('Log in')
    end

    it 'shows error with empty fields' do
      visit new_user_session_path
      click_button('commit')
      sleep(1)
      expect(page).to have_content 'Invalid Email or password.'
    end

    it 'shows error with wrong credentials' do
      visit new_user_session_path
      fill_in "user[email]",	with: "saadatali0202@gmail.com"
      fill_in "user[password]",	with: "123451"
      click_button 'commit'
      sleep 1
      expect(page).to have_content 'Invalid Email or password.'  
    end

    it 'logs in with right credentials' do
      visit new_user_session_path
      fill_in "user[email]",	with: "saadatali0202@gmail.com"
      fill_in "user[password]",	with: "123456"
      click_button 'commit'
      sleep 3
      expect(page).to have_content 'Signed in successfully.'
      expect(page).to have_current_path(root_path)
    end
  end
end
