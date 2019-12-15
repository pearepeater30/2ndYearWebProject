class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  #scope used to find posts belonging to the currently logged in user
  scope :user_posts, ->(user) {where(['user_id=?', user.id])}

  def likes_score
    likes.count
  end


end
