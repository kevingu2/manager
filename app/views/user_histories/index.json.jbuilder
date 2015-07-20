json.array!(@user_histories) do |user_history|
  json.extract! user_history, :id, :history_id, :user_id
  json.url user_history_url(user_history, format: :json)
end
