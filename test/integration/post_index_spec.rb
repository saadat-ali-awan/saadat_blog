require 'rails_helper'
include ActionView::Helpers::TextHelper
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
    long_body = 'Here, let\'s say clicking on the link \'foo\' triggers an asynchronous process, like an Ajax request, that adds the link \'bar\'. It\'s likely that second statement will fail since the link does not exist yet.'
    @post1 = Post.create(author: @first_user, title: 'Post 1', text: 'My Post 1')
    post2 = Post.create(author: @first_user, title: 'Post 2', text: long_body)
    post3 = Post.create(author: @first_user, title: 'Post 3', text: 'My Post 3')
    post4 = Post.create(author: @first_user, title: 'Post 4', text: 'My Post 4')
    post5 = Post.create(author: @second_user, title: 'Post 1 S', text: 'My Post 1 S')
    @posts = Post.where(author: @first_user)

    Comment.create(text: 'Comment 1', post: @post1, author: @first_user)
    Comment.create(text: 'Comment 2', post: @post1, author: @second_user)
    Comment.create(text: 'Comment 3', post: @post1, author: @first_user)
  end
  
  describe 'Home Page' do
    before :each do
      visit new_user_session_path
      fill_in "user[email]",	with: "saadatali0202@gmail.com"
      fill_in "user[password]",	with: "123456"
      click_button 'commit'
      sleep 2
      visit "/users/#{@first_user.id}/posts"
      sleep 2
    end

    it 'shows the profile picture for each user' do
      expect(page.has_xpath?("//img[@src = '#{@first_user.photo}' ]"))
    end

    it 'shows the username' do
      expect(page).to have_content(@first_user.name)
    end

    it 'shows the number of posts of the user' do
      expect(page).to have_content("Number of posts: #{@first_user.post_counter}")
    end

    it 'shows posts title' do
      @posts.each do |post|
        expect(page).to have_content(post.title)
      end
    end

    it 'shows some part of the post body' do
      @posts.each do |post|
        puts truncate(post.text, :length => 80)
        puts post.text
        expect(page).to have_content(truncate(post.text, :length => 80))
      end
    end
  end
end
