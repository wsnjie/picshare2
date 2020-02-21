class Number < ApplicationRecord
  has_many :pics
  has_one :user
end