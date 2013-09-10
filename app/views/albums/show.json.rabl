object @album
attributes :id, :title, :description, :user_id, :created_at, :points

child :creator => :creator do
  attributes :id, :username
end

child :images do
  attributes :id, :title, :description, :user_id, :album_id
  node(:url) { |image| image.file.url }
  node(:url_medium) { |image| image.file.url(:medium) }
  node(:url_small) { |image| image.file.url(:small) }
end