class Rating < ActiveRecord::Base
  attr_accessible :value
  
  belongs_to  :tune
end
