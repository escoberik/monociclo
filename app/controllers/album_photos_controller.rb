class AlbumPhotosController < ApplicationController
  before_filter :find_album, only: [:index, :create]
  before_filter :find_album_photo, only: [:update, :destroy]
  layout false

  def create
    @album_photo = @album.album_photos.create(params[:album_photo])

    render partial: 'album_photo', locals: { album_photo: @album_photo }
  end

  def update
    @album_photo.update_attributes(params[:album_photo])
    render text: 'ok'
  end

  def destroy
    @album_photo.destroy
    render text: "ok"
  end

private
  def find_album
    @album = Album.find(params[:album_id])
  end

  def find_album_photo
    @album_photo = AlbumPhoto.find(params[:id])
  end
end
