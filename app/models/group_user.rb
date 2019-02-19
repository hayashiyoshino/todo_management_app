class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validates :name, presence: true, uniqueness: true
end
