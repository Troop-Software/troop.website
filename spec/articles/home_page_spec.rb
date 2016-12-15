require 'rails_helper'


RSpec.feature 'Home page article display' do

  before do
    @user = User.create!(username: 'Test User', email: 'test@example.com', password: 'password')

    9.times do |x|
      Article.create!(title: Faker::Name.name, description: Faker::Lorem.paragraphs(2), user_id: @user.id)
    end

    @article = Article.create!(title: Faker::Name.name, description: Faker::Lorem.paragraphs(2), user_id: @user.id)
  end

  scenario 'when not signed in' do
    
    visit '/'
    expect(page).to have_link('Sign up now')
    expect(page).to have_link('Log in now')

    # login(@user)

    # #pagination is present (only 2 pages)
    # expect(page).to have_css('a.next_page')
    # expect(page).to have_css('body > div.container > div.tw_pagination > div > a:nth-child(3)')
    # expect(page).not_to have_css('body > div.container > div.tw_pagination > div > a:nth-child(5)')

    # #9 articles should be displayed
    # expect(page).to have_css('body > div.container > div.card-columns > div:nth-child(9)')
    # expect(page).not_to have_css('body > div.container > div.card-columns > div:nth-child(10)')

    # #first article
    # within ('body > div.container > div.card-columns > div:nth-child(1)') do
    #   expect(find('div.card-block > div.card-title > h4 > a').text).to eq @article.title
    #   expect(find('div.card-block > div.card-text').text[0..95]).to eq @article.description[0..95]
    #   expect(find('div.card-footer.small.text-muted').text).to include("Created by: #{@user.username}")
    # end

  end
end
