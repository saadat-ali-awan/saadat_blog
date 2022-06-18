require 'rails_helper'

RSpec.describe Comment, type: :model do
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
  subject do
    described_class.new(
      text: 'Good Post',
      author: post.author,
      post: post
    )
  end

  before { subject.save }

  it 'should be valid' do
    expect(subject).to be_valid
  end

  it 'should have text' do
    expect(subject).to be_valid
    subject.text = ''
    expect(subject).to_not be_valid
  end

  it 'should not have text=nil' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'should increment comment_counter by one' do
    subject.increment_post_comments_counter
    expect(subject.post).to be_valid
  end

  it 'should decrement comment_counter by one' do
    subject.decrement_post_comments_counter
    expect(subject.post).to be_valid
    subject.post.comment_counter = 0
    subject.decrement_post_comments_counter
    expect(subject.post).to be_valid
  end
end
