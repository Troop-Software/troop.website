require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest

  test 'admin user is not accessible if not logged in' do
    get admin_users_path
    assert_redirected_to user_session_path
  end

end
