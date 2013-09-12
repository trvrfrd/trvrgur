class RootController < ApplicationController
  def root
    @top_comments = Comment.top_comments.take(5)
    render :root
  end
end
