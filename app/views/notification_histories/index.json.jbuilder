json.array!(@notification_histories) do |notification_history|
  json.extract! notification_history, :id
  json.url notification_history_url(notification_history, format: :json)
end
