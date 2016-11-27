require 'rails_helper'

RSpec.feature 'Users Signup' do
  scenario 'with valid credentials' do
    visit '/'
    click_link 'Sign up now'
    fill_in 'Username', with: 'Test User'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content('You have signed up successfully.')
  end

  scenario 'with invalid email address' do
    visit '/'
    click_link 'Sign up now'
    fill_in 'Username', with: 'Test User'
    fill_in 'Email', with: 'testexample.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content('Email is invalid')
  end
end