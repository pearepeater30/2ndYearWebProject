require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "Should post request contact but no email" do
    post request_contact_url
    assert_response :redirect
    assert_not_empty flash[:alert]
    assert_nil flash[:notice]
  end

  test "Should post request contact" do
    post request_contact_url, params:
        {name: "Matthew", email: "matthew@me.com",
         telephone:"1234567890", message:"Hello"}
    assert_response :redirect
      assert_nil flash[:alert]
      assert_not_empty [:notice]
  end

end
