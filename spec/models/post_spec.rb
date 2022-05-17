# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  
  describe 'post creation' do
    context 'when post is created with required fields then it is valid' do
      subject { create(:post) }

      it { expect(subject).to be_valid }
    end

    context 'when title is not given then it is invalid' do
      subject { build(:post, title: nil) }

      it { expect(subject).to_not be_valid }
    end

    context 'when body is not given then it is invalid' do
      subject { build(:post, body: nil) }

      it { expect(subject).to_not be_valid }
    end

    context 'when user is not given then it is invalid' do
      subject { build(:post, user: nil) }

      it { expect(subject).to_not be_valid }
    end
  end

  describe 'dependencies' do
    it { is_expected.to have_many(:comments) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'One user cannot edit another user post' do
    it 'One user cannot edit another user post' do
      user1 = create(:user)
      user2 = create(:user)
      post1 = create(:post, user: user1)

      expect(user1.owner_of?(post1)).to be true
      expect(user2.owner_of?(post1)).to be false
    end
  end
end