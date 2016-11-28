require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  test 'categories is not accessible if not logged in' do
    get categories_path
    assert_redirected_to user_session_path
  end

end
