class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :send_mail

  def send_mail
    UserMailer.welcome_email(self).deliver
  end

  has_many :posts
  has_many :likes, dependent: :destroy
  has_many :comments
end
