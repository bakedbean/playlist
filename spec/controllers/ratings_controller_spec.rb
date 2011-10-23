require 'spec_helper'

describe RatingsController do
  
  before(:each) do
    @attr = Factory(:tune)
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new', :tune_id => @attr[:id]
      response.should be_success
    end
  end
  
  describe "POST 'create'" do
    
    before(:each) do
      @tune = Factory(:tune)
    end
    
    describe "success" do
      
      before(:each) do
        @attr = { :value => 3 }
      end
      
      it "should create a rating" do
        lambda do
          post :create, :tune_id => @tune[:id], :rating => @attr
        end.should change(Rating, :count).by(1)
      end
      
      it "should redirect to the tunes index" do
        post :create, :tune_id => @tune[:id], :rating => @attr
        response.should redirect_to(tunes_path)
      end
      
      it "should have a success message" do
        post :create, :tune_id => @tune[:id], :rating => @attr
        flash[:success].should =~ /#{@tune[:title]} rating set!/i
      end
    end
  end

end