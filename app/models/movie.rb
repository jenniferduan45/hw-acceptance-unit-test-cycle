class Movie < ActiveRecord::Base
  def self.search_same_director(director)
    if director.blank? or director.nil?
      return nil
    else
      Movie.where(director: director)
    end
  end
end
