require 'test_helper'

class RanksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rank = ranks(:one)
  end

  test 'ranks is not accessible if not logged in' do
    get ranks_url
    assert_redirected_to user_session_path
  end
end
