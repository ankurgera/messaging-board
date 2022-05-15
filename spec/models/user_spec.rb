# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'user account creation' do
    context 'when user is created with required fields then it is valid' do
      subject { create(:user) }

      it { expect(subject).to be_valid }
    end

    context 'when first_name is not given then it is invalid' do
      subject { build(:user, first_name: nil) }

      it { expect(subject).to_not be_valid }
    end

    context 'when last_name is not given then it is invalid' do
      subject { build(:user, last_name: nil) }

      it { expect(subject).to_not be_valid }
    end

    context 'when email is not given then it is invalid' do
      subject { build(:user, email: nil) }

      it { expect(subject).to_not be_valid }
    end
  end

  describe 'email unique' do
    subject { create(:user) }

    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  describe 'dependencies' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  describe 'test full_name method' do
    context 'when full_name method is called' do
      it 'verifies full_name method output' do
        user = create(:user, first_name: "John", last_name: "Doe")

        expect(user.full_name).to eq("John Doe")
      end
    end
  end
end