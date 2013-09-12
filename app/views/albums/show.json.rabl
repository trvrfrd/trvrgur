object @album
attributes :id, :title, :description, :user_id, :created_at, :points, :upvoted?, :downvoted?, :favorited?
node(:upvoted) { |album| album.upvoted_by?(current_user) }
node(:downvoted) { |album| album.downvoted_by?(current_user) }
node(:favorited) { |album| album.favorited_by?(current_user) }


child :creator => :creator do
  attributes :id, :username
end

child :images do
  attributes :id, :title, :description, :user_id, :album_id
  node(:url) { |image| image.file.url }
  node(:url_medium) { |image| image.file.url(:medium) }
  node(:url_small) { |image| image.file.url(:small) }
end

child :comments do
  attributes :id, :album_id, :parent_comment_id, :body, :created_at, :points
  node(:upvoted) { |comment| comment.upvoted_by?(current_user) }
  node(:downvoted) { |comment| comment.downvoted_by?(current_user) }

  child :author => :author do 
    attributes :id, :username 
  end
end
