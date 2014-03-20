json.array!(@apps) do |app|
  json.extract! app, :id, :name, :status, :url, :icon
  json.url app_url(app, format: :json)
end
