require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @post = posts(:post_one)
    @user = users(:user_one)
    sign_in @user
  end


  test 'should save valid comment' do
    comment = Comment.new

    comment.comment = 'MyComment'
    comment.user = @user
    comment.post = @post

    comment.save
    assert comment.valid?
  end

  test 'should save invalid comment' do
    comment = Comment.new
    comment.user = @user
    comment.post = @post

    comment.save
    refute comment.valid?
  end
end
