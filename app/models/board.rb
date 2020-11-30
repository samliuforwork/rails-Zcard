class Board < ApplicationRecord
  validates :title, presence: true, length: { minimum: 4 }

  has_many :posts
end
