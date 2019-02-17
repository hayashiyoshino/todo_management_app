class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  def self.search_by_lavel(lavelname = nil)
    lavelname ||= ""
    if lavelname != ""
      lavel = Lavel.find_by(lavel_name: lavelname)
      if lavel != nil
        return lavel.tasks
      else
        return nil
      end
    else
      return all
    end
  end
end
