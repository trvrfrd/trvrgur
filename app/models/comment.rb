class Comment < ActiveRecord::Base
  attr_accessible :album_id, :author_id, :body, :parent_comment_id
  validates :album_id, :author_id, :body, :presence => true

  belongs_to :album

  belongs_to :author,
             :class_name => "User",
             :foreign_key => :author_id

  belongs_to :parent_comment,
             :class_name => "Comment",
             :foreign_key => :parent_comment_id
  
  has_many :replies,
           :class_name => "Comment",
           :foreign_key => :parent_comment_id

  def points
    self.upvote_count - self.downvote_count
  end
end
