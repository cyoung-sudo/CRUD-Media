class Comment < ApplicationRecord
  validates :post_id, presence: true
  validates :content, presence: true, length: { minimum: 2, maximum: 100 }
  validates :user_id, presence: true

  belongs_to :post
  belongs_to :user
end