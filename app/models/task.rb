class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  enum status: [:untouched, :working, :done]

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
    end
  end

end
