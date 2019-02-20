class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  enum status: [:未着手, :着手中, :完了]

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
    else
      all
    end
  end

end
