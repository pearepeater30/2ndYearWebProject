require 'test_helper'

class PostTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:user_one)
    sign_in @user
  end

  test 'should save valid post' do
    post = Post.new

    post.title = 'My post'
    post.content = "My post's content"
    post.user = @user

    post.save
    assert post.valid?
  end

  test 'should not save post without title' do
    post = Post.new

    post.content = 'My post has no title'
    post.user = @user

    post.save
    refute post.valid?
  end

end
