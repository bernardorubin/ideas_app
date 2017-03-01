class Like < ApplicationRecord
  belongs_to :user
  belongs_to :idea
  # validation guarantees a user can only like an idea once
  validates :idea_id, uniqueness: {scope: :user_id}
end
