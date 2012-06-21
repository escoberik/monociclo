class PhotosController < ApplicationController
  def index
    @photos = Photo.all
    render layout: false
  end

  def show
    @photo = Photo.find(params[:id])

    redirect_to photos_path
  end

  def create
   @photo = Photo.create( params[:photo] )

   if request.xhr?
     render partial: 'photo', locals: { photo: @photo }
   else
     redirect_to photos_path
   end
  end

  def destroy
   @photo = Photo.find(params[:id])
   @photo.destroy

   render text: 'ok'
  end
end
