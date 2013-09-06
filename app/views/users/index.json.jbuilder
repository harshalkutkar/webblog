json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :username, :password, :address, :city, :state, :country, :profile_pic, :background_pic, :about
  json.url user_url(user, format: :json)
end
