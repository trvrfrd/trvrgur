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

  has_many :user_comment_upvotes, :dependent => :destroy
  has_many :upvoters, :through => :user_comment_upvotes, :source => :user

  has_many :user_comment_downvotes, :dependent => :destroy
  has_many :downvoters, :through => :user_comment_downvotes, :source => :user

  def self.fetch
    self.includes(:author, :upvoters, :downvoters)
  end

  def self.top_comments
    self.fetch.sort { |a, b| b.points <=> a.points }
  end

  def downvoted_by?(user)
    user && self.downvoter_ids.include?(user.id)
  end
  
  def points
    self.upvote_count - self.downvote_count
  end

  def upvoted_by?(user)
    user && self.upvoter_ids.include?(user.id)
  end
end
