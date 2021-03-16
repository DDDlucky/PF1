class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  attachment :profile_image, destroy: false

  validates :name, length: { maximum: 20, minimum: 2 }, uniqueness: true
  validates :introduction, length: { maximum: 500 }

  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :active_relationships,  class_name: "Relationship",
                                   foreign_key: "follower_id",
                                   dependent: :destroy

  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy

  has_many :following,                through: :active_relationships,
                                      source: :followed

  has_many :followers,                through: :passive_relationships,
                                      source: :follower

  # ユーザーをフォローする　<＜は配列に追加の意味
  def follow(other_user)
    following << other_user
  end

  # ユーザーのフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしていたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms

  # guestログイン
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
      end_user.name = "ゲスト太郎"
    end
  end
end
