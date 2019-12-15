require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:user_one)
    sign_in @user
  end
  test "should return user email" do
    mail = UserMailer.welcome_email(@user)
    assert_equal ['nathancgu@gmail.com'], mail.to
    assert_equal ['info@mynotes.com'], mail.from
  end
end
