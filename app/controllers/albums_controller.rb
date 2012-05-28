class AlbumsController < ApplicationController
  def new
  @album = Album.new
  @photo = Photo.all
  render :layout => false
  end
    
  def create
  end
  
  def show
  end
end
