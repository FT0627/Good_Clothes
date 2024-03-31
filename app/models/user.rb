class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :shops, dependent: :destroy

  has_many :fans, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :my_fans, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :followings, through: :fans, source: :followed
  has_many :followers, through: :my_fans, source: :follower

  has_one_attached :profile_image

  validates :name, presence: true
  validates :email, presence: true

 #画像調整機能
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

 # ゲストユーザー機能
  GUEST_USER_EMAIL = "guest@example.com"

    def self.guest
      find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
        user.password = SecureRandom.urlsafe_base64
        user.name = "ゲスト"
      end
    end

    def guest_user?
      email == GUEST_USER_EMAIL
    end

  #フォロー機能
  def follow(user_id)
    my_fans.create(followed_id: user_id)
  end

  def unfollow(user_id)
    my_fans.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

end
