class PhotosController < ApplicationController
  before_filter :authenticate
  
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
   @photo.resize = params[:resize]
   @photo.save

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

protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
    username == "sergio" && password == "glenn_jade"
    username == "abbyvalo" && password == "valo1808"
    end
  end
end
