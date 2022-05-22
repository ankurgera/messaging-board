json.extract! post, :id, :created_at, :updated_at
json.url post_url(post, format: :json)

if defined? comments
  json.comments comments
end