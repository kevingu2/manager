json.array!(@user_oppties) do |user_oppty|
  json.extract! user_oppty, :id, :oppty_id, :user_id
  json.url user_oppty_url(user_oppty, format: :json)
end
