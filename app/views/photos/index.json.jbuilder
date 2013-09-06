json.array!(@photos) do |photo|
  json.extract! photo, :id, :uid, :name, :caption, :tags, :bidder_id, :bid
  json.url photo_url(photo, format: :json)
end
