class Task < ApplicationRecord
  belongs_to :user
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
    where(status: pickup)
  end

  def self.pickup_priority_tasks(priority)
    return all if priority.blank?
    where(priority: priority)
  end

end
