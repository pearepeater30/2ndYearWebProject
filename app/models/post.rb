class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  has_many :likes, dependent: :destroy

  def likes_score
    likes.count
  end
end
