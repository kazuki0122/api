require 'test_helper'

class Api::V1::GroupRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_group_requests_index_url
    assert_response :success
  end

  test "should get create" do
    get api_v1_group_requests_create_url
    assert_response :success
  end

end
