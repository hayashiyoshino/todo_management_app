class Group < ApplicationRecord
  has_many :tasks
  has_many :users, through: :group_user
end
