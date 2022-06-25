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
    Post.create(author: @first_user, title: 'Post 3', text: 'My Post 3')
    Post.create(author: @first_user, title: 'Post 4', text: 'My Post 4')
    Post.create(author: @second_user, title: 'Post 1', text: 'My Post 1')
    @posts = Post.where(author: @first_user)
  end
  
  describe 'Home Page' do
    before :each do
      visit new_user_session_path
      fill_in "user[email]",	with: "saadatali0202@gmail.com"
      fill_in "user[password]",	with: "123456"
      click_button 'commit'
      sleep 2
      visit "/users/#{@first_user.id}"
      sleep 2
    end

    it 'shows the profile picture for each user' do
      expect(page.has_xpath?("//img[@src = '#{@first_user.photo}' ]"))
    end

    it 'shows username of all other users' do
      expect(page).to have_content(@first_user.name)
    end

    it 'shows the number of post for each user' do
      expect(page).to have_content("Number of posts: #{@first_user.post_counter}")
    end

    it 'shows the user bio' do
      expect(page).to have_content(@first_user.bio)
    end

    it 'shows first three posts' do
      @posts.each do |post|
        expect(page).to have_content(post.text) unless post.text == 'My Post 1'
      end
    end

    it 'has button to see all posts' do
      expect(page).to have_link('See all posts', href: "/users/#{@first_user.id}/posts")
    end

    it 'opens users post on click' do
      sleep 2
      find("a[href='/users/#{@first_user.id}/posts/4']").click
      sleep 2
      expect(page).to have_current_path("/users/#{@first_user.id}/posts/4")
    end

    it 'opens all posts on All post button click' do
      sleep 2
      find("a[href='/users/#{@first_user.id}/posts']").click
      sleep 2
      expect(page).to have_current_path("/users/#{@first_user.id}/posts")
    end
  end
end
