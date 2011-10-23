class RatingsController < ApplicationController
  def new
    @tune = Tune.find_by_id(params[:tune_id])
    @rating = Rating.new
  end
  
  def create
    @tune = Tune.find_by_id(params[:tune_id])
    @rating = @tune.rating.build(params[:rating])
    if @rating.save
      flash[:success] = "#{@tune[:title]} rating set!"
      redirect_to tunes_path
    else
      render 'new'
    end
  end

end
