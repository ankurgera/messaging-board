# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Posts", type: :feature do
  before do
    User.create(first_name: ENV['AUTOMATED_TEST_USER_FIRST_NAME'],
                last_name: ENV['AUTOMATED_TEST_USER_LAST_NAME'],
                email: ENV['AUTOMATED_TEST_USER_EMAIL'],
                password: ENV['AUTOMATED_TEST_USER_PASSWORD'])
  end

  describe "Create a Post" do
    it "Creates a Post" do
      # Users Sign in
      visit '/users/sign_in'
      fill_in 'Email', with: ENV['AUTOMATED_TEST_USER_EMAIL']
      fill_in 'Password', with: ENV['AUTOMATED_TEST_USER_PASSWORD']

      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully'

      # Create a Post
      click_button 'create_new_post'
  	  fill_in 'post_title', with: 'First Post'
  	  fill_in 'post_body', with: 'First Post Body'

  	  click_button 'Create Post'
  	  expect(page).to have_content 'Post was successfully created'

      # Users Sign out
  	  visit '/users/sign_out'
  	  expect(page).to have_content 'You need to sign in or sign up before continuing'
  	end
  end # End of describe "Create a Post"

  describe "Comment on a Post" do
    it "Comments on a Post" do
      # Users Sign in
      visit '/users/sign_in'
      fill_in 'Email', with: ENV['AUTOMATED_TEST_USER_EMAIL']
      fill_in 'Password', with: ENV['AUTOMATED_TEST_USER_PASSWORD']

      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully'

      # Create First Post
      click_button 'create_new_post'
  	  fill_in 'post_title', with: 'First Post'
  	  fill_in 'post_body', with: 'First Post Body'

  	  click_button 'Create Post'
  	  expect(page).to have_content 'Post was successfully created'

      # Post a Comment on the post
  	  fill_in 'comment_body', with: 'First Post Comment'
  	  click_button 'Submit'
  	  expect(page).to have_content 'Comment was successfully created'

      # Users Sign out
  	  visit '/users/sign_out'
  	  expect(page).to have_content 'You need to sign in or sign up before continuing'
    end
  end # End of describe "Comment on a Post"

  describe "Post 2 comments and veirfy if they are in order of creation" do
    it "Post 2 comments and veirfy if they are in order of creation" do
      # Users Sign in
      visit '/users/sign_in'
      fill_in 'Email', with: ENV['AUTOMATED_TEST_USER_EMAIL']
      fill_in 'Password', with: ENV['AUTOMATED_TEST_USER_PASSWORD']

      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully'

      # Create a Post
      click_button 'create_new_post'
  	  fill_in 'post_title', with: 'First Post'
  	  fill_in 'post_body', with: 'First Post Body'

  	  click_button 'Create Post'
  	  expect(page).to have_content 'Post was successfully created'

  	  # Post First Comment
  	  fill_in 'comment_body', with: 'First Comment'
  	  click_button 'Submit'
  	  expect(page).to have_content 'Comment was successfully created'

  	  # Post Second Comment
  	  fill_in 'comment_body', with: 'Second Comment'
  	  click_button 'Submit'
  	  expect(page).to have_content 'Comment was successfully created'

  	  # Verify if "First Comment" comes on the top and then after 
  	  # that "Second Comment" comes.
  	  post_comment_div = find(:xpath, "//div[@id='post_comments']")
  	  post_comment_div_contents = post_comment_div.native
  	  first_comment = post_comment_div_contents.children[1].children.text
  	  second_comment = post_comment_div_contents.children[5].children.text
  	  expect(first_comment).to have_text('First Comment')
  	  expect(second_comment).to have_text('Second Comment')

  	  # Users Sign out
  	  visit '/users/sign_out'
  	  expect(page).to have_content 'You need to sign in or sign up before continuing'
    end
  end # End of describe "Post 2 comments and veirfy if they are in order of creation"

  describe "Create 2 Post and verify if posts are in descending order" do
    it "Create 2 Post and verify if the last post is on the top" do
      # Users Sign in
      visit '/users/sign_in'
      fill_in 'Email', with: ENV['AUTOMATED_TEST_USER_EMAIL']
      fill_in 'Password', with: ENV['AUTOMATED_TEST_USER_PASSWORD']

      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully'

      # Create First Post
      click_button 'create_new_post'
      fill_in 'post_title', with: 'First Post'
      fill_in 'post_body', with: 'First Post Body'
      click_button 'Create Post'
      expect(page).to have_content 'Post was successfully created'

      # Click on "Back to Posts" button
      click_button 'back_to_posts'

      # Create Second Post
      click_button 'create_new_post'
      fill_in 'post_title', with: 'Second Post'
      fill_in 'post_body', with: 'Second Body'
      click_button 'Create Post'
      expect(page).to have_content 'Post was successfully created'

      # Click on "Back to Posts" button
      click_button 'back_to_posts'

      # Verify if the last post is on the top i.e. the "first post"
      # displayed on the top is the last one posted.
      within find('#all_posts') do
        first_post = first(".post_title")
        expect(first_post).to have_text 'Second Post'
      end

      # Users Sign out
      visit '/users/sign_out'
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end
  end # End of describe "Create 2 Post and verify if posts are in descending order"
end