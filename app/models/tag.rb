class Tag < ApplicationRecord
  validates :post_id, presence: true
  validates :content, presence: true, length: { minimum: 2, maximum: 26 }

  belongs_to :post
end
