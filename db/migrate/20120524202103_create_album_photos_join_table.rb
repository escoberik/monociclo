class CreateAlbumPhotosJoinTable < ActiveRecord::Migration
  
  def change
    create_table :album_photos do |t|
      t.integer :album_id
      t.integer :photo_id
    end
  end
end
