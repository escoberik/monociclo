class AlbumsController < ApplicationController
  
  def index
    @albums = Album.all
    
    render :json => @albums
  end
  
  def new
  @album = Album.new
  @photo = Photo.all
  render :layout => false
  end
    
  def create
    @album = Album.new(params[:album])
    @album.save
    render text: "OK"
  end
  
  def show
  end
end
