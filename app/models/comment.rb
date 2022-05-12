class Comment < ApplicationRecord
  validates :body, :post_id, :user_id, presence: true

  belongs_to :post
  belongs_to :user
end
