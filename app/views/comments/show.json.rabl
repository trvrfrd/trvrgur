object @comment
attributes :id, :album_id, :parent_comment_id, :body, :created_at, :points
node(:upvoted) { |comment| comment.upvoted_by?(current_user) }
node(:downvoted) { |comment| comment.downvoted_by?(current_user) }

child :author => :author do 
  attributes :id, :username 
end