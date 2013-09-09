class UserAlbumFavorite < ActiveRecord::Base
  attr_accessible :album_id, :user_id
end
