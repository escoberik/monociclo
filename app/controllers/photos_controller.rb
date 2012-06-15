class PhotosController < ApplicationController
  def index
    @photo = Photo.all
    render :layout => false
  end
  
  def show
    @photo = Photo.find(params[:id])
    
    redirect_to photos_path
  end

  
  def create
   @photo = Photo.create( params[:photo] )
   redirect_to photos_path
  end
  
  def destroy
   @photo = Photo.find_by_id(params[:id])   
   @photo.destroy
   redirect_to photos_path
  end
end
