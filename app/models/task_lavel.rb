class TaskLavel < ApplicationRecord
  belongs_to :lavel
  belongs_to :task
  validates :lavel_id, presence: true
  validates :task_id, presence: true
end
