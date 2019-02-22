class Task < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  has_many :task_lavels
  has_many :lavels, through: :task_lavels
  has_many_attached :files
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
    where(status: pickup)
  end

  def self.pickup_priority_tasks(priority)
    return all if priority.blank?
    where(priority: priority)
  end

end
