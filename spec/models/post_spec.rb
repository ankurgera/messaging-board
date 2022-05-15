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
end