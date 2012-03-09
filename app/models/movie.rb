class Movie < ActiveRecord::Base

def self.all_ratings
  ratings = Array.new
  Movie.find(:all, :select => "DISTINCT rating", :order => 'rating').each {|rating| 
    ratings<<rating.rating;
    }
  ratings
end

end