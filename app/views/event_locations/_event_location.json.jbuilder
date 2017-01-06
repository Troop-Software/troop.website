json.extract! event_location, :id, :name, :street, :city, :state, :zip, :type, :created_at, :updated_at
json.url event_location_url(event_location, format: :json)