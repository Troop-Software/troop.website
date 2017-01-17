Given(/^I am not authenticated$/) do
  visit destroy_user_session_path
end

When(/^I goto the login page$/) do
  visit new_user_session_path
end

And(/^I enter valid (.*) credentials$/) do |type|
  @email = Faker::Internet.email
  @password = 'testpassword'
  @username = Faker::Name.name
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
    when 'leader', 'leader_full', 'admin'
      user_leader = User.create(email: @email,
                      username: @username,
                      password: @password,
                      password_confirmation: @password,
                      confirmed_at: confirmed_at)
      admin_role = Role.find_or_create_by(name: 'admin')
      scout_role = Role.find_or_create_by(name: 'scout')
      parent_role = Role.find_or_create_by(name: 'parent')
      leader_role = Role.find_or_create_by(name: 'leader')
      leader_full_role = Role.find_or_create_by(name: 'leader_full')
      Assignment.find_or_create_by(user_id: user_leader.id, role_id: scout_role.id)
      Assignment.find_or_create_by(user_id: user_leader.id, role_id: parent_role.id)
      Assignment.find_or_create_by(user_id: user_leader.id, role_id: leader_role.id)
      Assignment.find_or_create_by(user_id: user_leader.id, role_id: leader_full_role.id) if type == 'leader_full'
      if type == 'admin'
        Assignment.find_or_create_by(user_id: user_leader.id, role_id: leader_full_role.id)
        Assignment.find_or_create_by(user_id: user_leader.id, role_id: admin_role.id)
      end


  end
  visit '/users/sign_in'
  fill_in 'user_email', :with => @email
  fill_in 'user_password', :with => @password
  click_button 'Log in'

end

Then(/^I am logged into the application$/) do
  expect(page).to have_title("Troop #{Rails.configuration.troop_website.troop_number} Website [Home Page]")
end


Then(/^I see the unconfirmed message$/) do
  expect(page).to have_selector('.alert')
end
