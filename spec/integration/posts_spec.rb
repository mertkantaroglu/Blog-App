require 'rails_helper'

RSpec.describe 'Post/index', type: :feature do
  before :each do
    # create a user to use in our tests
    @user = User.create(name: 'Bunny', photo: 'https://somewhere.com/an_ordinary_photo.jpg', bio: 'Anyone in this world', posts_counter: 0)
    @user.save
    # create a post to use in our tests
    @post = Post.create(author: @user, title: 'Nonsense', text: 'This guy should stop spitting bullshit')
    @post.save
  end
  # checks if the user's profile picture can be seen
  it 'should render the profile picture of the user' do
    visit user_posts_path(user_id: @user.id)
    expect(page).to have_css("img[src*='#{@user.photo}']")
  end

  # checks if the user's name can be seen
  it 'should render the username' do
    visit user_posts_path(user_id: @user.id)
    expect(page).to have_content(@user.name)
  end

  # checks the number of posts the user has written
  it 'should render the number of posts written by the user' do
    visit user_posts_path(user_id: @user.id)
    expect(page).to have_content(@user.posts_counter)
  end

  # checks if the post's title can be seen
  it 'should render the title of the post' do
    visit user_posts_path(user_id: @user.id)
    expect(page).to have_content(@post.title)
  end

  # checks if some of the post's text can be seen
  it 'should render the trimmed text of the post' do
    visit user_posts_path(user_id: @user.id)
    expect(page).to have_content(@post.text.truncate(40))
  end

  # checks if the first comment can be seen
  it 'should render the first comment of a post' do
    # create a comment to use in our tests
    comment = Comment.create(author: @user, post: @post, text: 'This is a comment')
    comment.save
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(comment.text)
  end

  # checks the number of comments in a post can be seen
  it 'should render the number of comments of a post' do
    # create a comment to use in our tests
    comment = Comment.create(author: @user, post: @post, text: 'This is a comment')
    comment.save
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@post.comments_counter)
  end

  # checks the number of likes in a post can be seen
  it 'should render the number of likes of a post' do
    # create a like to use in our tests
    like = Like.create(author: @user, post: @post)
    like.save
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@post.likes_counter)
  end

  # checks the section for pagination can be seen
  it 'should render a button pagination' do
    visit user_posts_path(user_id: @user.id)
    expect(page).to have_css('.pagination-btn')
  end

  # checks the link to the post's title redirects to that post's show page
  it 'should redirect to the post show page' do
    visit user_posts_path(user_id: @user.id)
    click_link @post.title
    expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @post.id))
  end

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
end
