# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  
  describe 'Comment creation' do
    context 'when comment is created with required fields then it is valid' do
      subject { create(:comment) }

      it { expect(subject).to be_valid }
    end

    context 'when body is not given then it is invalid' do
      subject { build(:comment, body: nil) }

      it { expect(subject).to_not be_valid }
    end

    context 'without a post it is invalid' do
      subject { build(:comment, post: nil) }

      it { expect(subject).to_not be_valid }
    end

    context 'without a user it is invalid' do
      subject { build(:comment, user: nil) }

      it { expect(subject).to_not be_valid }
    end
  end

  describe 'dependencies' do
    it { is_expected.to belong_to(:post) }
    it { is_expected.to belong_to(:user) }
  end
end