require 'test_helper'

class ScoutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scout = scouts(:one)
  end
  test 'scouts is not accessible if not logged in' do
    get scouts_url
    assert_redirected_to user_session_path
  end
end
