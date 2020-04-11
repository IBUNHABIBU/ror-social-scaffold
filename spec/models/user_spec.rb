require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  context 'Creating User' do
    it 'should give a user name' do
      user.name = 'Maya'
      expect(user.name).to eq('Maya')
    end
    it 'should give the user email' do
      user.email = 'maya@gmail.com'
      expect(user.email).to eq('maya@gmail.com')
    end
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
  it do
    should validate_length_of(:name).is_at_most(20).on(:create)
  end
  context 'User Associations' do
    it { should have_many(:friendships) }
    it { should have_many(:requested_friends).through(:friendships).source(:friend) }
    it { should have_many(:friends).through(:friendships) }
    it { should have_many(:pending_friends).through(:friendships).source(:friend) }
    it { should have_many(:blocked_friends).through(:friendships).source(:friend) }
  end
end
