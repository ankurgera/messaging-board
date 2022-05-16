# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Users", type: :feature do
  before do
    User.create(first_name: ENV['AUTOMATED_TEST_USER_FIRST_NAME'],
                last_name: ENV['AUTOMATED_TEST_USER_LAST_NAME'],
                email: ENV['AUTOMATED_TEST_USER_EMAIL'],
                password: ENV['AUTOMATED_TEST_USER_PASSWORD'])
  end

  describe "User Signs in and Signs out" do
    it "Signs in User and Signs out User" do
      visit '/users/sign_in'
      fill_in 'Email', with: ENV['AUTOMATED_TEST_USER_EMAIL']
      fill_in 'Password', with: ENV['AUTOMATED_TEST_USER_PASSWORD']

      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully'

      visit '/users/sign_out'
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end
  end
end