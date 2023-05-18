require 'rails_helper'

RSpec.describe Post, type: :model do
  post = Post.new(author_id: 1, title: 'first post', text: 'this is the first post', comments_counter: 3, likes_counter: 2)

  it 'checks the post author id' do
    expect(post.author_id).to eql 1
  end

  it 'checks title presence for post' do
    post.title = ''
    expect(post).to_not be_valid
    expect(post.title).to eql ''
  end

  it 'checks title length' do
    post.title = 'mrt' * 100
    expect(post).to_not be_valid
    expect(post.title.length).to eql 300
  end

  it 'checks text input' do
    expect(post.text).to_not eql ''
    expect(post.text).to eql 'this is the first post'
  end

  it 'has a valid number for comment counter' do
    post.comments_counter = -3
    expect(post).to_not be_valid
  end

  it 'has a valid number for comment counter' do
    post.comments_counter = 5
    expect(post.comments_counter).to eql 5
  end

  it 'has a valid number for likes counter' do
    post.likes_counter = -5
    expect(post).to_not be_valid
  end
end
