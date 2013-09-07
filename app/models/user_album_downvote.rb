class UserAlbumDownvote < ActiveRecord::Base
  attr_accessible :user_id, :album_id
  validates :user_id, :uniqueness => { :scope => :album_id }
  validates :album_id, :uniqueness => { :scope => :user_id }

  belongs_to :user
  belongs_to :album
end
