require 'spec_helper'

describe "Ratings" do
  
  describe "create" do
    
    before do
      @attr = { :url => "songs/some_song.mp3", :title => "Some Song", :artist_name => "Some Guy", :duration => 250 }
      @tune = Tune.create!(@attr)
    end
    
    it "should make a new rating" do
      lambda do
        visit new_tune_rating_path(@tune)
        fill_in "rating_value",  :with => 2
        click_button
        response.should have_selector("div.flash.success", :content => "#{@tune[:title]} rating set!")
        response.should render_template('tunes/index')
      end.should change(Rating, :count).by(1)
    end
  end
end