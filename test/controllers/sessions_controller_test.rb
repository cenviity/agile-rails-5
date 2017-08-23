require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should prompt for login" do
    get login_url
    assert_response :success
  end

  test "should log in" do
    dave = users(:one)
    post login_url, params: { name: dave.name, password: 'secret' }
    assert_redirected_to admin_url
    assert_equal dave.id, session[:user_id]
  end
  
  test "should fail login" do
    dave = users(:one)
    post login_url, params: { name: dave.name, password: 'wrong' }
    assert_redirected_to login_url
  end

  test "should log out" do
    delete logout_url
    assert_redirected_to store_index_url
  end
  
  test "should require authentication to fetch data" do
    delete logout_url
    get orders_url
    assert_redirected_to login_url
  end
  
  test "should require authentication to update data" do
    delete logout_url
    patch order_url(orders(:one)), params: { email: "new@email.com" }
    assert_redirected_to login_url
  end
end
