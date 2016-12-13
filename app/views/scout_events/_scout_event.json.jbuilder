json.extract! scout_event, :id, :scout_id, :event_id, :notes, :created_at, :updated_at
json.url scout_event_url(scout_event, format: :json)