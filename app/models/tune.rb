class Tune < ActiveRecord::Base
  attr_accessible :url, :title, :artist_name, :duration
  
  has_many  :rating, :dependent => :destroy
  
  url_regex = /^.*\.(mp3|MP3|m4a|M4A|mp4|MP4)$/i
  
  validates :url,       :presence => true,
                        :format     => { :with => url_regex, :message => "Please specify a valid audio file format" }
                        
  validates :title,     :presence => true
  validates :duration,  :numericality => { :only_integer => true }
  
  def average_rating
    total = 0
    average = 0.0
    
    self.rating.each do |n|
      total += n[:value]
    end
    
    unless self.rating.blank?
      average = (total.to_f / self.rating.size.to_f)
    end
    
    if average > 5
      average = 5
    end
    
    return average.round
  end
end
