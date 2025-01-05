json.extract! user, :id, :email_address, :name, :password_digest, :visible, :membership, :avatar_url, :description, :location, :created_at, :updated_at
json.url user_url(user, format: :json)
