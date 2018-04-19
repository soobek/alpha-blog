require 'test_helper'

class SigningUpTest < ActionDispatch::IntegrationTest
  
  test "signup" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {username:"Alexander", email:"alex2018@example.com", password:"password"}
    end
    assert_template 'users/show'
    assert_select 'div.alert'
    assert_match "Welcome to Alexander's page", response.body
  end
  
  test "invalid signup" do
    get signup_path
    assert_template 'users/new'
    assert_no_difference 'User.count' do
      post users_path, user: {username:" ", email:"alex2018@example.com", password:"password"}
    end
    assert_template 'users/new'
    assert_select 'div.panel-heading'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
end