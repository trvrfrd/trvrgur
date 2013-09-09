class RootController < ApplicationController
  def root
    @albums = Album.all.includes(:images, :comments)
    @comments = Comment.all
    render :root
  end
end
