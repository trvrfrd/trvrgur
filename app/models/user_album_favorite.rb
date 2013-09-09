class UserAlbumFavorite < ActiveRecord::Base
  attr_accessible :album_id, :user_id

  belongs_to :user
  belongs_to :album
end
