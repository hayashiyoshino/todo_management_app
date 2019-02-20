class Task < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :task_lavels
  has_many :lavels, through: :task_lavels
  validates :title, presence: true
  validates :description, presence: true
  enum status: [:untouched, :working, :done]
  enum priority: [:level0, :level1, :level2, :level3]

  def self.search(keyword = nil)
    where('title LIKE(?)', "%#{keyword}%")
  end

  def save_lavels(lavels)
    current_lavels = self.lavels.pluck(:lavel_name) unless self.lavels.nil?
    old_lavels = current_lavels - lavels
    new_lavels = lavels - current_lavels

    old_lavels.each do |old_lavel|
      self.lavels.delete Lavel.find_by(lavel_name: old_lavel)
    end

    new_lavels.each do |new_lavel|
      task_lavel = Lavel.find_or_create_by(lavel_name: new_lavel)
      self.lavels << task_lavel
    end
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

  def deadline_alert
    self.each do |task|
      if task.deadline < Date.current

      end
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
