require 'active_record'

class Transaction < ActiveRecord::Base
  belongs_to :user
  validates :amount, presence: true
  validates :category, presence: true
end
