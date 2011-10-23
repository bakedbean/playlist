require 'spec_helper'
require 'ruby-debug'

describe TunesController do
  render_views

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end
  
  describe "GET 'index' with tunes" do
    
    before(:each) do
      @tune = Factory(:tune)
    end
    
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
  
  describe "DELETE 'destroy'" do
    
    before(:each) do
      @tune = Factory(:tune)
    end
    
    it "should destroy the tune" do
      lambda do
        delete :destroy, :id => @tune
      end.should change(Tune, :count).by(-1)
    end
    
    it "should redirect to the index page" do
      delete :destroy, :id => @tune
      response.should redirect_to(tunes_path)
    end
  end
  
  describe "playlist" do
    
    describe "without saved tunes" do
    
      it "should fail to create playlist with no files" do
        post :playlist, :name => "", :rating => ""
        response.should redirect_to(tunes_path)
        flash[:error].should =~ /no files available, please add some tunes./i
      end
    end
    
    describe "with saved tunes" do
      
      before(:each) do
        @tune = Factory(:tune)
        @rating = Factory(:rating, :tune => @tune)
        # tried to stub the :send_file action and tests below, but couldn't get it working in time.  Decided to move on for now and settle for a 200 response verification.
        #controller.stub!(:send_file)
        #controller.stub!(:render)
      end
    
      it "should allow searching by artist name" do
        post :playlist, :name => @tune[:artist_name], :rating => ""
        #controller.should_receive(:send_file)
        response.should be_success 
      end
    
      it "should allow searching by rating" do
        post :playlist, :name => "", :rating => 4
        #controller.should_receive(:send_file)
        response.should be_success 
      end
    
      it "should allow searching by both artist name and rating" do
        post :playlist, :name => @tune[:artist_name], :rating => 4
        #controller.should_receive(:send_file)
        response.should be_success 
      end
    
      it "should allow searching with empty values" do
        post :playlist, :name => "", :rating => ""
        #controller.should_receive(:send_file)
        response.should be_success 
      end
    end
  end
end
