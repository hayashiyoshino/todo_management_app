class Group < ApplicationRecord
  has_many :tasks
  has_many :group_users
  has_many :users, through: :group_users, dependent: :destroy
end
