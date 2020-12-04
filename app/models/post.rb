class Post < ApplicationRecord
  belongs_to :board
  belongs_to :user
  has_many :comments

  has_many :favorite_posts
  has_many :favorite_users, through: :favorite_posts, source: 'user'
# 我想知道我這個使用者跟文章關係

  validates :title, presence: true
  validates :content, presence: true

  def owned_by?(user)
    self.user == user
  end
end
