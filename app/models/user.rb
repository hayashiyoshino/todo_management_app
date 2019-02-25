class User < ApplicationRecord
  has_many :tasks
  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
