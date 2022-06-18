require 'rails_helper'

RSpec.describe Like, :type => :model do
  user = User.create(
    name: 'Saadat',
    post_counter: 3
  )
  post = Post.create(
    title: 'My Title',
    text: 'My Testing Post',
    comment_counter: 12,
    like_counter: 12,
    author: user
  ) 
  subject { described_class.new(
    author: post.author,
    post: post
  ) }

  before { subject.save }

  it 'should be valid' do
    expect(subject).to be_valid
  end

  it 'should increment like_counter by one' do
    subject.increment_post_likes_counter
    expect(subject.post).to be_valid
  end

  it 'should decrement like_counter by one' do
    subject.decrement_post_likes_counter
    expect(subject.post).to be_valid
    subject.post.like_counter = 0
    subject.decrement_post_likes_counter
    expect(subject.post).to be_valid
  end
end