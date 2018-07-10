json.extract! user_site, :id, :user_id, :site_id, :created_at, :updated_at
json.url user_site_url(user_site, format: :json)
