class AddPositionToAlbumPhotos < ActiveRecord::Migration
  def change
    add_column :album_photos, :position, :integer
  end
end
