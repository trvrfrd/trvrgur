class RootController < ApplicationController
  def root
    @comments = Comment.all
    render :root
  end
end
