require 'test_helper'

class PositionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @position = positions(:one)
  end

  test 'positions is not accessible if not logged in' do
    get positions_url
    assert_redirected_to user_session_path
  end

end
