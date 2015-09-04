class User < ActiveRecord::Base
  has_secure_password
  has_secure_token

  has_many :meals

  validates :username, presence: true, length: { in: 2..20 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }, on: :create
  validates :target_calories, presence: true
end
