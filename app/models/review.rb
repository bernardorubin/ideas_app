class Review < ApplicationRecord
  belongs_to :idea
  belongs_to :user
  scope :last_first, -> {order("created_at DESC")}
end
