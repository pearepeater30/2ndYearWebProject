require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:post_one)
    @user = users(:user_one)
    @seconduser = users(:user_two)
    sign_in @user
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post posts_url, params: { post: { title: 'MyTitle', content: 'MyContent' } }
    end
    assert_redirected_to post_url(Post.last)
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
    assert_select 'h1', 'MyString'
    assert_select 'div.actual_post_content' do
      assert_select 'p', 'MyText'
    end
  end

  test "should get edit page" do
    get edit_post_path(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: {post: { title: 'MyUpdatedTitle', content: 'MyUpdatedContent' } }
    assert_redirected_to post_url(@post)
    get post_url(@post)
    assert_select 'h1', 'MyUpdatedTitle'
    assert_select 'div.actual_post_content' do
      assert_select 'p', 'MyUpdatedContent'
    end
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end
    assert_redirected_to root_path
  end

  test "should not create post" do
    assert_difference('Post.count', 0) do
      post posts_url, params: { post: { content: 'MyContent' } }
    end
  end

  test "should not get to edit post as different user" do
    sign_in @seconduser
    get edit_post_path(@post)
    assert_redirected_to root_path
  end

  test "should not update post with empty title" do
    patch post_url(@post), params: {post: { title: nil, content: 'MyUpdatedContent' } }
    assert_redirected_to root_path
  end

  test "should not delete post as different user" do
    sign_in @seconduser
    assert_difference('Post.count', 0) do
      delete post_url(@post)
    end
  end
end
