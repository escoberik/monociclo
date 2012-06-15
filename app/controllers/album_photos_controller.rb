class AlbumPhotosController < ApplicationController
  def show
    @album = Album.find(params[:id])
  end
  
  def update
    @photo = Photo.find(params[:photo_id])
    @album = Album.find(params[:id])
    
    @album.photos << @photo
    render text: "ok"
  end
  
  def destroy
    @album_photo = AlbumPhoto.find(params[:id])
    @album_photo.destroy
    redirect_to photos_path
  end
  
end
