require 'rails_helper'

RSpec.feature ' Adding friends ' do
  before do
    @maya = User.create(name: 'Maya', email: 'maya@gmail.com', password: '123456')
    @juma = User.create(name: 'Jumaa', email: 'juma@gmail.com', password: '123456')
    login_as(@juma)
  end
  scenario 'List of all users with friendship status' do
    visit users_path
    expect(page).to have_content(@maya.name)
    expect(page).to have_content(@juma.name)

    href = "/friendships?friend_id=#{@juma.id}"
    expect(page).not_to have_link('Add Friend', href: href)

    link = "a[href='/users']"
    find(link)
    expect(page).to have_link('Add Friend')
  end
end
