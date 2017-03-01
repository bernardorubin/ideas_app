class Idea < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :likers, through: :likes, source: :user
  has_many :likes, dependent: :destroy

  def liked_by?(user)
    likes.exists?(user: user)
  end

  def like_for(user)
    likes.find_by(user: user)
  end
end
