# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe 'GET /posts' do
    before do
      user = create(:user)
      sign_in user
      create(:post, title: "First Post")
      create(:post, title: "Second Post")
      create(:post, title: "Third Post")
      get posts_path
    end

    # Check if the posts are in descending order
    # on the posts index page.
    it do
      res_body = response.body
      # JSON.parse is throwing an error. Due to time crunch,
      # I am implementing the following solution.
      first_post_index = res_body.index("First Post")
      third_post_index = res_body.index("Third Post")

      expect(response).to have_http_status(:ok)
      expect(third_post_index).to be < first_post_index
    end
  end

  describe 'GET /posts/id' do
    before do
      user = create(:user)
      sign_in user
      post = create(:post, title: "First Post")
      create(:comment, post: post, user: user, body: "First Comment")
      create(:comment, post: post, user: user, body: "Second Comment")
      get post_path(post)
    end

    # Check if the comments on a post are in ascending order
    # on the post show page.
    it do
      res_body = response.body
      # JSON.parse is throwing an error. Due to time crunch,
      # I am implementing the following solution.
      first_comment_index = res_body.index("First Comment")
      second_comment_index = res_body.index("Second Comment")

      expect(response).to have_http_status(:ok)
      expect(first_comment_index).to be < second_comment_index
    end
  end
end
