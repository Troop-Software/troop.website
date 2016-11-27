require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
  end

  test 'articles is not accessible if not logged in' do
    get articles_url
    assert_redirected_to user_session_path
  end

end
