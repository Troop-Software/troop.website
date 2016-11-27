require 'rails_helper'

RSpec.feature 'Users Sign out' do

  before do
    @user = User.create!(username: 'Test User', email: 'test@example.com', password: 'password')
    login(@user)
  end

  scenario  do
    visit '/'
    click_link 'CurrentUser'
    click_link 'Log out'
    expect(page).to have_content('Signed out successfully.')
  end
end
