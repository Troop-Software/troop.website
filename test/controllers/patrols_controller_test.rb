require 'test_helper'

class PatrolsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @patrol = patrols(:one)
  end

  test 'patrols is not accessible if not logged in' do
    get patrols_url
    assert_redirected_to user_session_path
  end

end
