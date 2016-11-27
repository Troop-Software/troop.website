require 'rails_helper'

RSpec.feature 'Users Sign In' do

  before do
    @user = User.create!(username: 'Test User', email: 'test@example.com', password: 'password')
  end

  scenario 'with valid credentials' do
    visit '/'
    click_link 'Log in now'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
  end
end