require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new(name: 'Mert', photo: 'www.unsplash.com', bio: 'Lorem ipsum', posts_counter: 5)

  it 'name is present' do
    expect(user).to be_valid
    expect(user.name).to eql 'Mert'
  end

  it 'should have a link for photo' do
    expect(user.photo).to_not eql ''
    expect(user.photo).to eql 'www.unsplash.com'
  end

  it 'should have a bio text' do
    expect(user.bio).to_not eql ''
    expect(user.bio).to eql 'Lorem ipsum'
  end

  it 'has a number greater than zero for the post counter' do
    user.posts_counter = -5
    expect(user).to_not be_valid
    expect(user.posts_counter).to eql(-5)
  end
end
