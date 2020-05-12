class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }
  validates :user_id, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :received_likes, foreign_key: :post_id, class_name: "Like"
  has_many :likes, through: :received_likes, source: :user, dependent: :destroy
end
