require 'test_helper'

class LikeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @post1 = posts(:post_one)
    @post2 = posts(:post_two)
    @user1 = users(:user_one)
    #signing in as user_one
    sign_in @user1
  end
  test "should create like" do
    assert_difference('Like.count', 1) do
      post post_like_index_path(@post1)
      assert_equal(@post1.id, Like.last.post_id)
    end
  end

  test "should destroy like" do
    post post_like_index_path(@post2)
    assert_difference('Like.count', -1) do
      delete post_like_path(post_id: @post2.id, id: Like.last.id)
    end
  end

  #test explanation: a like for post_two already exists in fixture belonging to @user1. More than one like belonging to
  # one user is forbidden, therefore the count of likes should not increase
  test "should not like a post more than once" do
    assert_difference('Like.count', 0) do
      post post_like_index_path(@post2)
    end
  end
end
