json.array!(@albums) do |json, album|
  json.id    album.id
  json.title album.title
end
