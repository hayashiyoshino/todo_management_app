class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  enum status: [:未着手, :着手中, :完了]
  enum priority: [:緊急度０, :緊急度１, :緊急度２, :緊急度３]

  def self.search(keyword = nil)
    val ||= ""
    where('title LIKE(?)', "%#{keyword}%")
  end

end
