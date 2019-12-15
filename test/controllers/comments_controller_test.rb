require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @post = posts(:post_one)
    @user = users(:user_one)
    sign_in @user
  end

  test "should create comment" do
    assert_difference('Comment.count', 1) do
      post post_comments_url(@post), params: { comment: {comment: 'MyComment'}}
      assert_equal(@post.id, Comment.last.post_id)
    end
  end
end
