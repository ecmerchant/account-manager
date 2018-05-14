require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get manage" do
    get accounts_manage_url
    assert_response :success
  end

end
