class StaticPagesController < ApplicationController
  def index
    @photos = Photo.for_page 'Home'
  end

  def prensa
    @photos = Photo.for_page 'Prensa'
  end
end
