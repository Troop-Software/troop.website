require 'rails_helper'

RSpec.feature 'Navigation bar' do

  before do
    @user = User.create!(username: 'Test User', email: 'test@example.com', password: 'password')
    @admin_user = User.create!(username: 'Admin User', email: 'test2@example.com', password: 'password', admin: true)
  end

  scenario 'when not signed in' do
    visit '/'
    expect(page).to have_link('Troop.Website', href: root_path)
    expect(page).to have_link('Log In', href: new_user_session_path)
    expect(page).to have_link('Sign Up', href: new_user_registration_path)
  end

  scenario 'when signed is as normal user' do
    login(@user)
    visit root_path
    expect(page).to have_link('Troop.Website', href: root_path)
    expect(page).to have_link('View')
    expect(page).to have_link('Scouts', href: scouts_path)
    expect(page).to have_link('Patrols', href: patrols_path)
    expect(page).to have_link('Positions', href: positions_path)
    expect(page).to have_link('Ranks', href: ranks_path)
    expect(page).to have_link('Articles', href: articles_path)
    expect(page).to have_link('Requirements')
    expect(page).to have_link('Scout', href: requirements_path(by_rank_id: 2))
    expect(page).to have_link('Tenderfoot', href: requirements_path(by_rank_id: 3))
    expect(page).to have_link('Second Class', href: requirements_path(by_rank_id: 4))
    expect(page).to have_link('First Class', href: requirements_path(by_rank_id: 5))
    expect(page).to have_link('Star', href: requirements_path(by_rank_id: 6))
    expect(page).to have_link('Life', href: requirements_path(by_rank_id: 7))
    expect(page).to have_link('Eagle', href: requirements_path(by_rank_id: 8))
    expect(page).not_to have_link('Admin')
    expect(page).not_to have_link('Categories', href: categories_path)
    expect(page).not_to have_link('Users', href: profiles_path)
    expect(page).not_to have_link('User Devise', href: admin_home_path)
    expect(page).to have_link(@user.username)
    expect(page).to have_link('Profile', href: profile_path(@user.id))
    expect(page).to have_link('Account', href: edit_user_registration_path)
    expect(page).to have_link('Log out', href: destroy_user_session_path)
    expect(page).not_to have_link('Log In', href: new_user_session_path)
    expect(page).not_to have_link('Sign Up', href: new_user_registration_path)
  end

  scenario 'when signed in as an admin user' do
    login(@admin_user)
    visit root_path
    expect(page).to have_link('Troop.Website', href: root_path)
    expect(page).to have_link('View')
    expect(page).to have_link('Scouts', href: scouts_path)
    expect(page).to have_link('Patrols', href: patrols_path)
    expect(page).to have_link('Positions', href: positions_path)
    expect(page).to have_link('Ranks', href: ranks_path)
    expect(page).to have_link('Articles', href: articles_path)
    expect(page).to have_link('Requirements')
    expect(page).to have_link('Scout', href: requirements_path(by_rank_id: 2))
    expect(page).to have_link('Tenderfoot', href: requirements_path(by_rank_id: 3))
    expect(page).to have_link('Second Class', href: requirements_path(by_rank_id: 4))
    expect(page).to have_link('First Class', href: requirements_path(by_rank_id: 5))
    expect(page).to have_link('Star', href: requirements_path(by_rank_id: 6))
    expect(page).to have_link('Life', href: requirements_path(by_rank_id: 7))
    expect(page).to have_link('Eagle', href: requirements_path(by_rank_id: 8))
    expect(page).to have_link('Admin')
    expect(page).to have_link('Requirements', href: requirements_path)
    expect(page).to have_link('Categories', href: categories_path)
    expect(page).to have_link('Users', href: profiles_path)
    expect(page).to have_link('User Devise', href: admin_home_path)
    expect(page).to have_link(@admin_user.username)
    expect(page).to have_link('Profile', href: profile_path(@admin_user.id))
    expect(page).to have_link('Account', href: edit_user_registration_path)
    expect(page).to have_link('Log out', href: destroy_user_session_path)
    expect(page).not_to have_link('Log In', href: new_user_session_path)
    expect(page).not_to have_link('Sign Up', href: new_user_registration_path)
  end
end
