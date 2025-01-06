require 'active_record'

class User < ActiveRecord::Base
  has_many :transactions
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  # For password hashing
  has_secure_password
end
