require 'rails_helper'

describe 'Testing Post/show', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Mert', photo: 'www.unsplash.com', bio: 'Web Developer guy', posts_counter: 3)

    @user2 = User.create(name: 'Larissa', photo: 'www.unsplash.com', bio: 'Bee keeper and bee lover', posts_counter: 2)

    @first_post = Post.create(author: @user1, title: 'Hello World', text: 'This is my first post', comments_counter: 1, likes_counter: 2)

    @first_comment = Comment.create(post: @first_post, author: @user1, text: 'First comment for the post')
    @second_comment = Comment.create(post: @first_post, author: @user1, text: 'Second comment for the post')
    @third_comment = Comment.create(post: @first_post, author: @user1, text: 'Third comment for the post')

    @first_like = Like.create(post: @first_post, author: @user1)
    @second_like = Like.create(post: @first_post, author: @user1)
    @third_like = Like.create(post: @first_post, author: @user1)

    visit user_posts_path(@user1, @first_post)
  end

  it 'displays posts title' do
    expect(page).to have_content(@first_post.title)
  end

  it 'displays the author of the post' do
    expect(page).to have_content(@user1.name)
  end

  it 'displays the number of the comments for the post' do
    expect(page).to have_content(@first_post.comments_counter)
  end

  it 'displays the number of the likes for the post' do
    expect(page).to have_content(@first_post.likes_counter)
  end

  it 'displays the text for the post' do
    expect(page).to have_content(@first_post.text)
  end

  it 'displays username of each commenters' do
    expect(page).to have_content(@first_comment.author.name)
    expect(page).to have_content(@second_comment.author.name)
    expect(page).to have_content(@third_comment.author.name)
  end

  it 'displays comments of each commenters' do
    expect(page).to have_content(@first_comment.text)
    expect(page).to have_content(@second_comment.text)
    expect(page).to have_content(@third_comment.text)
  end
end
