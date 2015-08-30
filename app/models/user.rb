class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true, length: { in: 2..20 }
  validates :password_digest, presence: true
  validates :password, presence: true, length: { minimum: 8 }, on: :create
  validates :token, presence: true
  validates :admin, presence: true
end
