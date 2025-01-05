json.extract! profile, :id, :handle, :avatar, :description, :location, :visibility, :user_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)
