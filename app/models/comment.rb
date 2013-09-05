class Comment < ActiveRecord::Base
  attr_accessible :album_id, :author_id, :body, :parent_comment_id
end
