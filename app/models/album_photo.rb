require 'jade'
class AlbumPhoto < ActiveRecord::Base
  include Jade::Utilities::Orderable
  orderable with_scope: :album_id

  attr_protected nil
  belongs_to :album
  belongs_to :photo
end
