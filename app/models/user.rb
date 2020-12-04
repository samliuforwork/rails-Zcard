class User < ApplicationRecord
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: /[\w]+@([\w-]+\.)+[\w-]{2,4}/ }
  validates :password, presence: true,
                       confirmation: true,
                       length: { minimum: 4 }
  validates :nickname, presence: true
  before_create :encrypt_password

  has_many :posts
  has_many :comments
  has_many :favorite_posts
  has_many :my_favorites, through: :favorite_posts, source: 'post'
  
  def self.login(user)
    pw = Digest::SHA1.hexdigest("a#{user[:password]}z")
    User.find_by(email: user[:email], password: pw)
  end

  # 在一個陣列中查詢一個陣列是否包含?
  def favorite?(post)
    my_favorites.include?(post)
  end
  private
  def encrypt_password
    self.password = Digest::SHA1.hexdigest("a#{self.password}z")
  end
end
