class User < ApplicationRecord
  has_secure_password
  has_many :ideas, dependent: :nullify
  has_many :liked_ideas, through: :likes, source: :idea
  has_many :likes, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}".strip.titleize
  end
end
