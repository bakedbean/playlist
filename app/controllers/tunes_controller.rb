class TunesController < ApplicationController
  def new
    @tune = Tune.new
  end
  
  def index
    @tunes = Tune.find(:all)
  end
  
  def create
    @tune = Tune.new(params[:tune])
    if @tune.save
      flash[:success] = "#{@tune[:title]} saved!"
      redirect_to tunes_path
    else
      render 'new'
    end
  end
  
  def destroy
    Tune.find(params[:id]).destroy
    flash[:success] = "Tune deleted."
    redirect_to tunes_path
  end
  
  def playlist
    tunes = search(params[:name],params[:rating]).sort_by { rand }
    
    filename = "#{Rails.public_path}/playlists/playlist_#{DateTime.now.hour}#{DateTime.now.min}#{DateTime.now.sec}.m3u"
    
    unless tunes.blank?
    
      File.new(filename, 'w')

      file = File.open(filename, 'w'){ |f|
      
        f.write("#EXTM3U\n")
        f.write("\n")
        tunes.each do |song|
          f.write("#EXTINF:#{song.duration},#{song.artist_name} - #{song.title}")
          f.write("\n")
          f.write("#{song.url}")
          f.write("\n")
          f.write("\n")
        end    
      }
    end

    if File.exists?(filename)
      send_file filename, :type => 'audio/x-mpegurl'
    else
      flash[:error] = "No files available, please add some tunes."
      redirect_to tunes_path
    end
  end
  
  def search(name,rating_val)
        
    if !name.empty? && !rating_val.empty?
      
      Tune.where("artist_name LIKE ?","%#{name}%")
          .find(:all, 
                :select => "tunes.*, AVG(ratings.value) AS average", 
                :joins => :rating, 
                :group => 'tunes.id', 
                :conditions => { :ratings => { :value => rating_val } })
    elsif !name.empty?
      
      Tune.where("artist_name LIKE ?","%#{name}%").all()
    elsif !rating_val.empty?
      
      Tune.find(:all, :select => "tunes.*, AVG(ratings.value) AS average", 
                      :joins => :rating, 
                      :group => 'tunes.id', 
                      :conditions => { :ratings => { :value => rating_val } })
    else
      
      Tune.find(:all)
    end
  end

end
