class User < ApplicationRecord
  has_many :tasks
  validates :name, :email, presence: true
end
