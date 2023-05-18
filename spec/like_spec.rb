require 'rails_helper'

RSpec.describe Like, type: :model do
  like = Like.new(author_id: 1, post_id: 1)

  it 'has an author id' do
    expect(like.author_id).to_not eql 5
    expect(like.author_id).to eql 1
  end

  it 'has an post id' do
    expect(like.post_id).to_not eql(-5)
    expect(like.post_id).to eql 1
  end
end
