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
    else
      all
    end
  end

  def self.pickup_priority_tasks(priority)
    return all if priority.blank?
    case priority
    when 'level0'
      where(priority: 'level0')
    when 'level1'
      where(priority: 'level1')
    when 'level2'
     where(priority: 'level2')
    when 'level3'
      where(priority: 'level3')
    else
      all
    end
  end

end
