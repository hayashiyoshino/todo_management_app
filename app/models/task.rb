class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  enum status: [:untouched, :working, :done]
  enum priority: [:level0, :level1, :level2, :level3]

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

  def self.pickup_tasks(pickup)
    return all if pickup.blank?
    case pickup
    when 'untouched'
      where(status: 'untouched')
    when 'working'
      where(status: 'working')
    when 'done'
      where(status: 'done')
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
