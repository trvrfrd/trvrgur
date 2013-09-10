object @album
attributes :title, :description, :user_id, :created_at

child :creator => :creator do
  attributes :username
end

child :images do
  attributes :title, :description, :user_id, :album_id
  node(:url) { |image| image.file.url }
  node(:url_medium) { |image| image.file.url(:medium) }
  node(:url_small) { |image| image.file.url(:small) }
end