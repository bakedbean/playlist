require 'spec_helper'

describe Tune do
  
  before(:each) do
    @attr = { :url => "/tunes/new_song.mp3", :title => "New Song", :artist_name => "Some Dude", :duration => 120}
  end
  
  it "should create a new instance given valid attributes" do
    Tune.create!(@attr)
  end
  
  it "should require a url" do
    no_url_tune = Tune.new(@attr.merge(:url => ""))
    no_url_tune.should_not be_valid
  end
  
  it "should require a title" do
    no_title_tune = Tune.new(@attr.merge(:title => ""))
    no_title_tune.should_not be_valid
  end
  
  describe "ratings" do
    
    before(:each) do
      @tune = Factory(:tune)
      @tune.rating.create!({ :value => 2 })
      @tune.rating.create!({ :value => 4 })
      @tune.rating.create!({ :value => 5 })
    end
    
    it "should calculate the average of saved ratings" do
      @tune.average_rating.should == 4
    end
  end
end
