class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
  validates :user_id, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :received_likes, foreign_key: :post_id, class_name: "Like"
  has_many :likes, through: :received_likes, source: :user, dependent: :destroy
end
