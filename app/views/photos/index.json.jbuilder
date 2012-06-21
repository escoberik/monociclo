json.array!(@photos) do |json, photo|
  json.id    photo.id
  json.title photo.title
end
