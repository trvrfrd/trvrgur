class Album < ActiveRecord::Base
  attr_accessible :description, :title, :user_id
  validates :images, :presence => true

  belongs_to :creator,
             :class_name => "User",
             :foreign_key => :creator_id
             
  has_many :images, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  has_many :upvotes,
           :class_name => "UserAlbumUpvote",
           :foreign_key => :album_id
           
  has_many :upvoting_users, :through => :upvotes, :source => :user

  has_many :downvotes,
           :class_name => "UserAlbumDownvote",
           :foreign_key => :album_id
           
  has_many :downvoting_users, :through => :downvotes, :source => :user


  def comments_by_parent_id
    comments = self.comments.all
    result = Hash.new { |hash, key| hash[key] = [] }

    comments.each do |c|
      result[c.parent_comment_id] << c
    end
    
    result
  end

  def points
    self.upvotes - self.downvotes
  end
end
