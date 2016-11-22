require 'test_helper'

class PatrolsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @patrol = patrols(:one)
  end

  test "should get index" do
    get patrols_url
    assert_response :success
  end

  test "should get new" do
    get new_patrol_url
    assert_response :success
  end

  test "should create patrol" do
    assert_difference('Patrol.count') do
      post patrols_url, params: { patrol: { name: @patrol.name } }
    end

    assert_redirected_to patrol_url(Patrol.last)
  end

  test "should show patrol" do
    get patrol_url(@patrol)
    assert_response :success
  end

  test "should get edit" do
    get edit_patrol_url(@patrol)
    assert_response :success
  end

  test "should update patrol" do
    patch patrol_url(@patrol), params: { patrol: { name: @patrol.name } }
    assert_redirected_to patrol_url(@patrol)
  end

  test "should destroy patrol" do
    assert_difference('Patrol.count', -1) do
      delete patrol_url(@patrol)
    end

    assert_redirected_to patrols_url
  end
end
