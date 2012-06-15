class AlbumPhoto < ActiveRecord::Base
  attr_protected nil
  belongs_to :album
  belongs_to :photo
end
