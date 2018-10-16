class UserCommentUpvote < ActiveRecord::Base
  validates :user_id, :uniqueness => { :scope => :comment_id }
  validates :comment_id, :uniqueness => { :scope => :user_id }

  belongs_to :user
  belongs_to :comment
end
