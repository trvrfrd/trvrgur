class Album < ApplicationRecord
  belongs_to :creator,
             :class_name => "User",
             :foreign_key => :creator_id,
             optional: true

  has_many :images, :dependent => :destroy
  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: :all_blank

  has_many :comments, :dependent => :destroy

  has_many :user_album_upvotes, :dependent => :destroy
  has_many :upvoters, :through => :user_album_upvotes, :source => :user

  has_many :user_album_downvotes, :dependent => :destroy
  has_many :downvoters, :through => :user_album_downvotes, :source => :user

  has_many :user_album_favorites, :dependent => :destroy
  has_many :favoriting_users, :through => :user_album_favorites, :source => :user

  validates :images, :presence => true

  def self.fetch
    self.includes(:images,
                  :creator,
                  :upvoters,
                  :downvoters,
                  :favoriting_users,
                  :comments => [:author, :downvoters, :upvoters])
  end

  def comments_by_parent_id
    result = Hash.new { |hash, key| hash[key] = [] }

    comments.to_a.each do |c|
      result[c.parent_comment_id] << c
    end

    result
  end

  def favorited_by?(user)
    user && favoriting_user_ids.include?(user.id)
  end

  def downvoted_by?(user)
    user && downvoter_ids.include?(user.id)
  end

  def points
    upvote_count - downvote_count
  end

  def upvoted_by?(user)
    user && upvoter_ids.include?(user.id)
  end
end
