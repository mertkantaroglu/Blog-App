require 'rails_helper'

RSpec.describe Comment, type: :model do
  comment = Comment.new(author_id: 1, post_id: 1, text: 'first comment')

  it 'has a author id number' do
    expect(comment.author_id).to_not eql(-3)
    expect(comment.author_id).to eql 1
  end

  it 'has a post id number' do
    expect(comment.post_id).to_not eql(-5)
    expect(comment.post_id).to eql 1
  end

  it 'has a text for comment' do
    comment.text = ''
    expect(comment.text).to_not eql 'first comment'
  end
end
