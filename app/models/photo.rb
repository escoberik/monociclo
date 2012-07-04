class Photo < ActiveRecord::Base
  attr_protected nil
  has_many :album_photos, dependent: :destroy
  has_many :albums, :through => :album_photos

  has_attached_file :photo,
    styles: {
      thumb: '100x100#',
      resize: '960x525#'
    }

  def self.for_page(page_name)
    album = Album.find_by_title(page_name)

    if album.blank?
      []
    else
      album.album_photos.order('position').map(&:photo)
    end
  end
end
