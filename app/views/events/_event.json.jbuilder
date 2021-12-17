json.extract! event, :id, :name, :event_type, :properties, :created_at, :updated_at
json.url event_url(event, format: :json)
