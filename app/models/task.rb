class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  enum status: [:未着手, :着手中, :完了]
  enum priority: [:緊急度０, :緊急度１, :緊急度２, :緊急度３]

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
    when '緊急度０'
      where(priority: '緊急度０')
    when '緊急度１'
      where(priority: '緊急度１')
    when '緊急度２'
      where(priority: '緊急度２')
    when '緊急度３'
      where(priority: '緊急度３')
    else
      order('created_at DESC')
    end
  end

end
