Given(/^I am not authenticated$/) do
  visit destroy_user_session_path
end

When(/^I goto the login page$/) do
  visit new_user_session_path
end

And(/^I enter valid (.*) credentials$/) do |type|
  @email = 'testing@man.net'
  @password = 'secretpass'
  @username = 'testUser'
  confirmed_at = Date.today
  case type
    when 'confirmed'
    User.new(email: @email,
             username: @username,
             password: @password,
             password_confirmation: @password,
             confirmed_at: confirmed_at).save!
    when 'unconfirmed'
      User.new(email: @email,
               username: @username,
               password: @password,
               password_confirmation: @password).save!

  end
  visit '/users/sign_in'
  fill_in 'user_email', :with => @email
  fill_in 'user_password', :with => @password
  click_button 'Log in'

end

Then(/^I am logged into the application$/) do
  expect(page).to have_title('Troop 433 Website [Home Page]')
end


Then(/^I see the unconfirmed message$/) do
  expect(page).to have_selector('.alert')
end
