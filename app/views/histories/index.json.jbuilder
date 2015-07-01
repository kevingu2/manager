json.array!(@histories) do |history|
  json.extract! history, :id, :opptyName, :opptyId, :oppty_id, :user_id
  json.url history_url(history, format: :json)
end
