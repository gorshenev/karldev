json.array!(@events) do |event|
  json.extract! event, :title, :location, :start, :end
  json.location event.location(:db)
  json.title event.title
  json.start event.start.to_formatted_s(:db)
  json.end event.end.to_formatted_s(:db)
  json.allDay false
  json.url event_url(event, format: :html)
end
