require 'rails_helper'

describe 'Users', type: :request do
  describe 'GET all users' do
    it 'checks whether it brings a successful response' do
      get '/users'

      expect(response).to be_successful
    end

    it 'renders the index template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'displays the body paragraph for users' do
      user1 = User.create(name: 'Mert', photo: 'www.unsplash.com', bio: 'Test', posts_counter: 3)

      get users_path

      expect(response.body).to include(user1.name)
    end
  end

  describe 'GET specific user' do
    user = User.create!(name: 'Mert', photo: 'www.unsplash.com', bio: 'Test', posts_counter: 3)

    it 'checks whether it brings a successful response' do
      get "/users/#{user.id}"
      expect(response).to be_successful
    end

    it 'renders the show template' do
      get "/users/#{user.id}"
      expect(response).to render_template(:show)
    end

    it 'displays the body paragraph for a specific user' do
      user = User.create(name: 'Mert', photo: 'www.unsplash.com', bio: 'Test', posts_counter: 3)

      get "/users/#{user.id}"

      expect(response.body).to include(user.bio)
      expect(response.body).to include("Number of posts: #{user.posts_counter}")
    end
  end
end
