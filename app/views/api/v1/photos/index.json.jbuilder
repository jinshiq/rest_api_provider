json.array!(@photos) do |photo|
  json.extract! photo, :id, :title
  json.image URI.join(request.url, photo.image.url).to_s
  json.url api_v1_photo_url(photo, format: :json)
end
