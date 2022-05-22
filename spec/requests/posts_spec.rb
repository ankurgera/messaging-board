# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe 'GET /posts' do
    before do
      user = create(:user)
      sign_in user
      @post1 = create(:post, title: "First Post")
      @post2 = create(:post, title: "Second Post")
      @post3 = create(:post, title: "Third Post")
      get posts_path, headers: { 'ACCEPT' => 'application/json' }
    end

    # Check if the posts are in descending order
    # on the posts index page.
    it do
      json_body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      # Third Post Comes First
      expect(json_body.first["id"]).to eq(@post3.id)
      # First Post Comes Last
      expect(json_body.last["id"]).to eq(@post1.id)
    end
  end

  describe 'GET /posts/id' do
    before do
      user = create(:user)
      sign_in user
      post = create(:post, title: "First Post")
      @comment1 = create(:comment, post: post, user: user, body: "First Comment")
      @comment2 = create(:comment, post: post, user: user, body: "Second Comment")
      get post_path(post), headers: { 'ACCEPT' => 'application/json' }
    end

    # Check if the comments on a post are in ascending order
    # on the post show page.
    it do
      json_body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(json_body["comments"].first["id"]).to eq(@comment1.id)
      expect(json_body["comments"].last["id"]).to eq(@comment2.id)
    end
  end
end
