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

  def self.login(user)
    pw = Digest::SHA1.hexdigest("a#{user[:password]}z")
    User.find_by(email: user[:email], password: pw)
  end

  private
  def encrypt_password
    self.password = Digest::SHA1.hexdigest("a#{self.password}z")
  end
end
