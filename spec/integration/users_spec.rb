require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'

describe 'testing users/index', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Mert', photo: 'www.unsplash.com', bio: 'Web Developer guy', posts_counter: 3)

    @user2 = User.create(name: 'Larissa', photo: 'www.unsplash.com', bio: 'Bee keeper and bee lover', posts_counter: 2)

    @user3 = User.create(name: 'Burak', photo: 'www.unsplash.com', bio: 'Software developer from Turkey', posts_counter: 2)

    @users = User.all
    visit users_path
  end

  it 'diplays user name of all users' do
    @users.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  it 'displays profile picture for each user' do
    @users.each do |_user|
      expect(page).to have_css('img')
    end
  end

  it 'displays the number of posts each user has written' do
    @users.each do |user|
      expect(page).to have_content "Number of posts: #{user.posts_counter}"
    end
  end

  it 'redirects to user\'s show page when clicked' do
    @users.each do |user|
      click_link("user-link-#{user.id}")
      expect(page).to have_current_path(user_path(user))
      visit users_path
    end
  end
end

RSpec.describe 'Testing User/show', type: :feature do
  before :each do
    # create a user to use in our tests
    @user = User.create(name: 'Bunny', photo: 'https://somewhere.com/an_ordinary_photo.jpg',
                        bio: 'Anyone in this world')
    @user.save
  end
  # checks if the user's profile picture can be seen
  it 'should render the profile picture of the user' do
    visit user_path(@user)
    expect(page).to have_css("img[src*='https://somewhere.com/an_ordinary_photo.jpg']")
  end

  # checks if the user's name can be seen
  it 'should render the user name' do
    visit user_path(@user)
    expect(page).to have_content(@user.name)
  end

  # checks the number of posts the user has written
  it 'should render the number of posts written by the user' do
    visit user_path(@user)
    expect(page).to have_content(@user.posts_counter)
  end

  # checks if the user's bio can be seen
  it 'should render the bio of the user' do
    visit user_path(@user)
    expect(page).to have_content(@user.bio)
  end

  # checks the user's first 3 posts can be seen
  it 'should render the first 3 posts of the user' do
    # create a posts to use in our test
    posts = [
      { title: 'trail',
        text: 'answer bent visitor raw stock elephant roof supper numeral bend previous donkey stand wild there' },
      { title: 'sweater',
        text: 'end me low officer enjoy cool phrase could shut cattle military chair parent fruit sunlight with' },
      { title: 'outer',
        text: 'teach soon origin calm crew writing bee sheep brave create saved remember must unless any society' }
    ]

    posts.each do |post_attrs|
      Post.create(author: @user, **post_attrs).save
    end
    visit user_path(@user)
    posts.first(3).each do |post|
      expect(page).to have_content(post[:title])
    end
  end

  # checks the button that lets view all of a user's posts can be seen
  it 'should render the button that lets view all of a user\'s posts' do
    visit user_path(@user)
    expect(page).to have_link('See all posts', href: user_posts_path(user_id: @user.id), class: 'all-posts-btn')
  end

  # checks the link to the user's post redirects to that post's show page
  it 'should redirect to the post show page' do
    # create a post to use in our test
    post = Post.create(author: @user, title: 'Nonsense', text: 'This guy should stop spitting bullshit')
    post.save
    visit user_path(@user)
    click_link post.title
    expect(page).to have_current_path(user_post_path(user_id: @user.id, id: post.id))
  end

  # checks the button see all posts redirects to the user's post's index page
  it 'should redirect to the user\'s post index page' do
    visit user_path(@user)
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(@user))
  end
end
