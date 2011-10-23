require 'spec_helper'

describe "Tunes" do
  
  describe "create" do
    
    describe "failure" do
      
      it "should not make a new tune" do
        lambda do
          visit new_tune_path
          fill_in "url",                :with => ""
          fill_in "title",              :with => ""
          fill_in "tune_artist_name",   :with => ""
          fill_in "duration",           :with => ""
          click_button
          response.should render_template('tunes/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(Tune, :count)
      end
    end
    
    describe "success" do
      
      it "should make a new tune" do
        lambda do
          visit new_tune_path
          fill_in "url",              :with => "/songs/some_tune.mp3"
          fill_in "title",            :with => "Some Song"
          fill_in "tune_artist_name", :with => "Some Guy"
          fill_in "duration",         :with => "250"
          click_button
          response.should have_selector("div.flash.success", :content => "Some Song saved!")
          response.should render_template('tunes/index')
        end.should change(Tune, :count).by(1)
      end
    end
  end
end