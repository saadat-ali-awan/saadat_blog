require 'rails_helper'
require 'htmlentities'
RSpec.describe 'Post Show', type: :system do
  include ActionView::Helpers::TextHelper

  def create_posts
    long_body = 'Here, let\'s say clicking on the link \'foo\' triggers an asynchronous process, like an Ajax request,
     that adds the link \'bar\'. It\'s likely that second statement will fail since the link does not exist yet.'
    @post1 = Post.create(author: @first_user, title: 'Post 1', text: 'My Post 1')
    Post.create(author: @first_user, title: 'Post 2', text: long_body)
    Post.create(author: @first_user, title: 'Post 3', text: 'My Post 3')
    Post.create(author: @first_user, title: 'Post 4', text: 'My Post 4')
    Post.create(author: @second_user, title: 'Post 1 S', text: 'My Post 1 S')
    @posts = Post.where(author: @first_user)
  end

  def create_comments
    Comment.create(text: 'Comment 1', post: @post1, author: @first_user)
    Comment.create(text: 'Comment 2', post: @post1, author: @second_user)
    Comment.create(text: 'Comment 3', post: @post1, author: @first_user)
  end
  before :all do
    Comment.delete_all
    Like.delete_all
    Post.delete_all
    User.delete_all
    @coder = HTMLEntities.new
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
    create_posts
    create_comments
  end
  describe 'Page' do
    before :each do
      visit new_user_session_path
      fill_in 'user[email]', with: 'saadatali0202@gmail.com'
      fill_in 'user[password]', with: '123456'
      click_button 'commit'
      sleep 2
      visit "/users/#{@first_user.id}/posts/#{@post1.id}"
      sleep 2
    end

    it 'shows post\'s title' do
      expect(page).to have_content @post1.title
    end

    it 'shows post\'s owner' do
      user = User.find(@post1.user_id)
      expect(page).to have_content user.name
    end

    it 'shows how many comments a post has' do
      expect(page).to have_content "Comments: #{@post1.comment_counter}"
    end

    it 'shows how many likes a post has' do
      expect(page).to have_content "Likes: #{@post1.like_counter}"
    end

    it 'shows post body' do
      expect(page).to have_content @post1.text
    end

    it 'shows username of each commentor' do
      comments = @post1.comments
      comments.each do |comment|
        user = User.find(comment.user_id)
        expect(page).to have_content user.name
      end
    end

    it 'shows comment of each commentor' do
      comments = @post1.comments
      comments.each do |comment|
        expect(page).to have_content comment.text
      end
    end
  end
end
