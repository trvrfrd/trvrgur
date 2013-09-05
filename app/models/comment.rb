class Comment < ActiveRecord::Base
  attr_accessible :album_id, :author_id, :body, :parent_comment_id

  belongs_to :album

  belongs_to :author,
             :class_name => "User",
             :foreign_key => :author_id,
             :primary_key => :id

  belongs_to :parent_comment,
             :class_name => "Comment",
             :foreign_key => :parent_comment_id,
             :primary_key => :id
  
  has_many :replies,
           :class_name => "Comment",
           :foreign_key => :parent_comment_id,
           :primary_key => :id

end
