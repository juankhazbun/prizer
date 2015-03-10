json.array!(@prizes) do |prize|
  json.extract! prize, :id, :description, :existences
  json.url prize_url(prize, format: :json)
end
