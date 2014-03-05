json.array!(@links) do |link|
  json.extract! link, :id, :target_url, :short_name
  json.url link_url(link, format: :json)
end
