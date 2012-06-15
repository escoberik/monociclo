json.array!(@album.album_photos) do |json, album_photo|
  json.id  album_photo.id
  json.url album_photo.photo.photo.url(:medium)
end
