require 'rails_helper'

RSpec.describe 'Page', type: :system do
  before :all do
    Comment.delete_all
    Like.delete_all
    Post.delete_all
    User.delete_all
    @first_user ||= User.create(
      name: 'Tom',
      photo: 'https://live.staticflickr.com/65535/52122569383_698a119861_z.jpg',
      bio: 'A teacher from Mexico',
      email: 'saadatali0202@gmail.com',
      password: '123456',
      created_at: '2022-06-15 01:40:30.027196000 +0000',
      confirmed_at: '2022-06-14 21:22:04.937699'
    )
    @second_user ||= User.create(
      name: 'Saadat',
      photo: 'https://avatars.githubusercontent.com/u/35307862?s=400&u=7cfb77f8b9bac6a4292449d0864d5a752c2cbf5a&v=4',
      bio: 'A programmer from Pakistan',
      email: 'saadatali@gmail.com',
      password: '123456',
      created_at: '2022-06-15 01:40:30.027196000 +0000',
      confirmed_at: '2022-06-14 21:22:04.937699'
    )
    Post.create(author: @first_user, title: 'Post 1', text: 'My Post 1')
    Post.create(author: @first_user, title: 'Post 2', text: 'My Post 2')
    Post.create(author: @second_user, title: 'Post 1', text: 'My Post 1')
  end

  describe 'Page' do
    before :each do
      visit new_user_session_path
      fill_in 'user[email]',	with: 'saadatali0202@gmail.com'
      fill_in 'user[password]',	with: '123456'
      click_button 'commit'
      sleep 2
      visit root_path
      sleep 2
    end

    it 'shows the right content' do
      expect(page).to have_content('Number of posts: ')
    end

    it 'shows username of all other users' do
      expect(page).to have_content(@first_user.name)
      expect(page).to have_content(@second_user.name)
    end

    it 'shows the profile picture for each user' do
      expect(page.has_xpath?("//img[@src = '#{@first_user.photo}' ]"))
      expect(page.has_xpath?("//img[@src = '#{@second_user.photo}' ]"))
    end

    it 'shows the number of post for each user' do
      expect(page).to have_content("Number of posts: #{@first_user.post_counter}")
      expect(page).to have_content("Number of posts: #{@second_user.post_counter}")
    end

    it 'opens users page on click' do
      sleep 2
      find("a[href='/users/#{@first_user.id}']").click
      sleep 2
      expect(page).to have_current_path("/users/#{@first_user.id}")
    end
  end
end
