require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::TestHelpers
  setup do
    @user = users(:one)
  end
  test "the truth" do
    assert true
  end


  test 'should save valid post' do
    post = Post.new

    post.title = 'My post'
    post.content = "My post's content"
    post.user = @user

    post.save
    assert post.valid?
  end
end
