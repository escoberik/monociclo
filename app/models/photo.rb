class Photo < ActiveRecord::Base
  attr_protected nil
  has_many :album_photos, dependent: :destroy
  has_many :albums, :through => :album_photos

  has_attached_file :photo,
    styles: {
      thumb: '100x100#'
    }
end
