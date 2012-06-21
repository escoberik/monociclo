class AlbumsController < ApplicationController
  def index
    @albums = Album.all
  end

  def create
    @album = Album.create(params[:album])
  end
end
