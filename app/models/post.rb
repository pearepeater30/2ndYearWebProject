class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # TODO remove liked_post scope if unneeded
  scope :user_posts, ->(user) {where(['user_id=?', user.id])}
  scope :liked_posts, ->(like) {where(['user_id=?', like.id])}

  def likes_score
    likes.count
  end


end
