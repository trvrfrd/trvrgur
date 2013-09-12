object @comment
attributes :id, :album_id, :parent_comment_id, :body

child :author => :author do
  attributes :id, :username
end