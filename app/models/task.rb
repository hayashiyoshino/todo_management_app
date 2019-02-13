class Task < ApplicationRecord
  belongs_to :user
  has_many :task_lavels
  has_many :lavels, through: :task_lavels
  validates :title, presence: true
  validates :description, presence: true
  enum status: [:未着手, :着手中, :完了]
  enum priority: [:緊急度０, :緊急度１, :緊急度２, :緊急度３]

  def self.search(keyword = nil)
    val ||= ""
    where('title LIKE(?)', "%#{keyword}%")
  end

  def self.sort_priority(keyword = nil)
    val ||= ""
    if keyword == nil
      all
    else
      where(priority: keyword)
    end
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

end
