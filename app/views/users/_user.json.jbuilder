json.extract! user, :id, :email, :name, :visible, :site_role, :avatar_url, :description, :location, :created_at, :updated_at
json.url user_url(user, format: :json)
