class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, length: { minimum: 2, maximum: 26 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 26 }

  has_many :posts, dependent: :destroy
  has_many :comments
end
