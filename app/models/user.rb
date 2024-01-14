class User < ApplicationRecord
  has_secure_password
  has_secure_token :confirmation_token
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true
end
