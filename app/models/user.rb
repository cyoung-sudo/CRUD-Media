class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, length: { minimum: 2, maximum: 26 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 26 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :received_follows, foreign_key: :followee_id, class_name: "Follow"
  has_many :followers, through: :received_follows, source: :follower, dependent: :destroy
  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
  has_many :followings, through: :given_follows, source: :followee, dependent: :destroy
  
  has_many :given_likes, foreign_key: :user_id, class_name: "Like"
  has_many :liked, through: :given_likes, source: :post, dependent: :destroy
  has_attached_file :avatar, styles: { medium: "300x300#", thumb: "100x100#" }, default_url: "missing_:style.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def full_name
    "#{self.first_name} #{self.last_name}".titleize
  end
end
