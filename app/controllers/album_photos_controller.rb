class AlbumPhotosController < ApplicationController
  before_filter :find_album, only: [:index, :create]
  layout false

  def create
    @album_photo = @album.album_photos.create(photo: Photo.find(params[:photo_id]))

    render partial: 'album_photo', locals: { album_photo: @album_photo }
  end

  def destroy
    @album_photo = AlbumPhoto.find(params[:id])
    @album_photo.destroy

    render text: "ok"
  end

private
  def find_album
    @album = Album.find(params[:album_id])
  end
end
