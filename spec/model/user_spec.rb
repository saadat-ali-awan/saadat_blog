require 'rails_helper'

RSpec.describe User, :type => :model do
  subject { described_class.new }

  before { subject.save }

  it 'should have name and post_counter set' do
    expect(subject).to_not be_valid
  end

  it 'should not have blank name'  do
    subject.post_counter = 3   
    subject.name = ""
    expect(subject).to_not be_valid
    subject.name = "A"
    expect(subject).to be_valid
  end

  it 'post_counter should not be nil' do
    subject.post_counter = nil
    expect(subject).to_not be_valid
  end

  it 'post_counter must not be less than 1' do
    subject.post_counter = -1
    expect(subject).to_not be_valid
  end
  it 'should have post counter greater than euqal to 0' do
    subject.post_counter = 0
    expect(subject).to_not be_valid
  end
end