class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  enum status: [:未着手, :着手中, :完了]

  def self.search(keyword = nil)
    where('title LIKE(?)', "%#{keyword}%")
  end

  def self.sort_tasks(sort=nil)
    sort ||= ""
    case sort
    when 'asc'
      order('deadline ASC')
    when 'desc'
      order('deadline DESC')
    when '未着手'
      where(status: '未着手')
    when '着手中'
      where(status: '着手中')
    when '完了'
      where(status: '完了')
    else
      order('created_at DESC')
    end
  end

end
