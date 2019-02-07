class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  enum status: [:未着手, :着手中, :完了]
end
