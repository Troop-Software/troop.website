require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  def setup
    @user = User.create!(username: "#{Faker::StarWars.character}",
                 email: Faker::Internet.email,
                 password: '123456')
  end

  test 'article can be saved' do
    article = Article.new(title: 'abcd' , description: 'description', user_id: @user.id)
    assert article.save
  end

  test 'article must have title' do
    article = Article.new
    assert_not article.save
  end

  test 'article must have description' do
    article = Article.new(title: 'article name')
    assert_not article.save
  end

  test 'article must have user_id' do
    article = Article.new(title: 'article title', description: 'description')
    assert_not article.save
  end

  test 'article title length restrictions' do
    article = Article.new(title: 'a', description: 'description', user_id: @user)
    assert_not article.save
    article = Article.new(title: 'a'*51 , description: 'description', user_id: @user.id)
    assert_not article.save
  end

  test 'article description length restrictions' do
    article = Article.new(title: 'article title', description: 'a'*9, user_id: @user)
    assert_not article.save
    article = Article.new(title: 'article title', description: 'a'*1001, user_id: @user)
    assert_not article.save
  end

end
