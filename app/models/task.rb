class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  enum status: [:未着手, :着手中, :完了]

  def self.search(keyword = nil)
    val ||= ""
    where('title LIKE(?)', "%#{keyword}%")
  end

end
