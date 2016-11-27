require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest

  test 'admin home is not accessible if not logged in' do
    get admin_home_url
    assert_redirected_to user_session_path
  end

end
