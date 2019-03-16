class Lavel < ApplicationRecord
  has_many :task_lavels
  has_many :tasks, through: :task_lavels
end
