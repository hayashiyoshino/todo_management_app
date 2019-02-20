class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  enum status: [:未着手, :着手中, :完了]
  enum priority: [:緊急度０, :緊急度１, :緊急度２, :緊急度３]

  def self.search(keyword = nil)
    where('title LIKE(?)', "%#{keyword}%")
  end

  def self.sort_tasks(sort=nil)
    sort ||= ""
    if sort == 'asc'
      order('deadline ASC')
    elsif sort == 'desc'
      order('deadline DESC')
    else
      order('created_at DESC')
    end
  end

  def self.pickup_tasks(pickup=nil)
    pickup ||= ""
    case pickup
    when '未着手'
      where(status: '未着手')
    when '着手中'
      where(status: '着手中')
    when '完了'
      where(status: '完了')
    when '緊急度０'
      where(priority: '緊急度０')
    when '緊急度１'
      where(priority: '緊急度１')
    when '緊急度２'
      where(priority: '緊急度２')
    when '緊急度３'
      where(priority: '緊急度３')
    else
      all
    end
  end

end
