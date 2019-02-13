class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true



  def self.sort_deadline(sort=nil)
    sort ||=""
    if sort == 'asc'
      order('deadline ASC')
    elsif sort == 'desc'
      order('deadline DESC')
    else
      order('created_at DESC')
    end
  end


end
