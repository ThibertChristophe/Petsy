class User < ApplicationRecord
  attr_accessor :avatar_file

  has_secure_password
  has_secure_token :confirmation_token
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true
  validates :avatar_file, file: { ext: %i[jpg png] }
end
