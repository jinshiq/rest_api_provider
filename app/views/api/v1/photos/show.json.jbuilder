json.extract! @photo, :id, :title, :created_at, :updated_at
json.image URI.join(request.url, @photo.image.url).to_s
json.url api_v1_photo_url(@photo, format: :json)  
