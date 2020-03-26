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
end