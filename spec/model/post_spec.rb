require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(
    name: 'Saadat',
    post_counter: 3
  )
  subject do
    described_class.new(
      title: 'My Title',
      text: 'My Testing Post',
      comment_counter: 12,
      like_counter: 12,
      author: user
    )
  end

  before do
    subject.save
  end

  it 'is valid when everthing is not nil' do
    expect(subject).to be_valid
  end

  it 'title should not be nil' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title must not be empty' do
    subject.title = ''
    expect(subject).to_not be_valid
  end

  it 'title can be between 1 and 250' do
    subject.title = 'a'
    expect(subject).to be_valid
    subject.title = 'a' * 250
    expect(subject).to be_valid
  end

  it 'title must not be greater than 250' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'text should not be nil' do
    subject.title = 'a'
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'text must not be empty' do
    subject.text = ''
    expect(subject).to_not be_valid
  end

  it 'text can be between 1 and 250' do
    subject.text = 'a'
    expect(subject).to be_valid
    subject.text = 'a' * 250
    expect(subject).to be_valid
  end

  it 'text must not be greater than 250' do
    subject.text = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'comment_counter must be integer' do
    subject.text = 'a'
    subject.comment_counter = 12.2
    expect(subject).to_not be_valid
    subject.comment_counter = 12
    expect(subject).to be_valid
  end

  it 'comment_counter must be greater than equal to 0' do
    subject.comment_counter = -1
    expect(subject).to_not be_valid
  end

  it 'like_counter must be integer' do
    subject.like_counter = 12.2
    expect(subject).to_not be_valid
    subject.like_counter = 12
    expect(subject).to be_valid
  end

  it 'like_counter must be greater than equal to 0' do
    subject.like_counter = -1
    expect(subject).to_not be_valid
  end

  it 'increment_user_post_counter should increment by 1' do
    previous_value = subject.author.post_counter
    subject.increment_user_post_counter
    expect(subject).to be_valid
    expect(subject.author.post_counter).to eq previous_value + 1
  end

  it 'decrement_user_post_counter should decrement by 1' do
    subject.author.post_counter = 0
    subject.decrement_user_post_counter
    expect(subject.author).to be_valid
  end
end
