json.array!(@album.photos) do |json, photo|
  json.id  photo.id
  json.url photo.photo.url(:medium)
  
end
