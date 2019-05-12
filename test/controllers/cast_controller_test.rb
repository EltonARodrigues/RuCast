require 'test_helper'

class CastControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get cast_new_url
    assert_response :success
  end

  test "should get create" do
    get cast_create_url
    assert_response :success
  end

end
