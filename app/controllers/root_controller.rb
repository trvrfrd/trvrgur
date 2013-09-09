class RootController < ApplicationController
  def root
    @albums = nil
    @comments = nil
    render :root
  end
end
