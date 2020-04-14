require 'rails_helper'

RSpec.feature ' listing all my friends ' do
  before do
    @maya = User.create(name: 'Maya', email: 'maya@gmail.com', password: '123456')
    @juma = User.create(name: 'Jumaa', email: 'juma@gmail.com', password: '123456')
    login_as(@juma)
  end
  scenario 'Show current_user name, email and friends count' do
    visit root_path
    expect(page).to have_link('Friends')
    expect(page).to have_content(@juma.name)
    expect(page).to have_content(@juma.email)
    expect(page).to have_content(@juma.friends.count)

    href = "/friendships?friend_id=#{@juma.id}"
    expect(page).not_to have_link('Add Friend', href: href)

    link = "a[href='/users']"
    find(link)
    expect(page).to have_link('Add Friend')
  end
  scenario 'List of all my friends' do
    visit root_path
    expect(page).to have_link('Friends')
    expect(page).to have_content(@juma.name)
    expect(page).to have_content(@juma.email)
    expect(page).to have_content(@juma.friends.count)

    href = "/friendships?friend_id=#{@juma.id}"
    expect(page).not_to have_link('Add Friend', href: href)

    link = "a[href='/users']"
    find(link)
    expect(page).to have_link('Add Friend')
  end
end