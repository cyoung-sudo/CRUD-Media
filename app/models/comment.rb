class Comment < ApplicationRecord
  validates :post_id, presence: true
  validates :content, presence: true, length: { minimum: 10, maximum: 500 }
  validates :user_id, presence: true

  belongs_to :post
  belongs_to :user
end