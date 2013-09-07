class Album < ActiveRecord::Base
  attr_accessible :description, :title, :user_id
  validates :images, :presence => true

  belongs_to :creator,
             :class_name => "User",
             :foreign_key => :creator_id
             
  has_many :images, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  has_many :user_album_upvotes, :dependent => :destroy
  has_many :upvoters, :through => :user_album_upvotes, :source => :user

  has_many :user_album_downvotes, :dependent => :destroy
  has_many :downvoters, :through => :user_album_downvotes, :source => :user


  def comments_by_parent_id
    comments = self.comments.all
    result = Hash.new { |hash, key| hash[key] = [] }

    comments.each do |c|
      result[c.parent_comment_id] << c
    end
    
    result
  end

  def points
    self.upvote_count - self.downvote_count
  end
end
