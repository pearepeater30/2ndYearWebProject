require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should return contact email" do
    mail = ContactMailer.contact_email("matthew@me.com", "Matthew Casey",
                                       "1234567890", @message = "Hello")
    assert_equal ['info@mynotes.com'], mail.to
    assert_equal ['matthew@me.com'], mail.from
  end

  test "does not send email with no variables" do
    ContactMailer.contact_email(nil,nil,nil,nil)
    assert_no_emails
  end
end
