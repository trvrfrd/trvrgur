class AlbumsController < ApplicationController
  before_action :require_logged_in, :except => [:create, :index, :new, :show]

  def create
    @album = Album.new(new_album_params)
    @images = @album.images
    if @album.save
      flash[:notices] ||= []
      flash[:notices] << "album created successfully"
      redirect_to root_url
    else
      flash.now[:alerts] ||= []
      flash.now[:alerts] += @album.errors.full_messages
      flash.now[:alerts] += @images.map { |i| i.errors.full_messages }
      render :new
    end
  end

  # TODO: this should redirect somewhere if current user doesn't own album!
  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to root_url
  end

  def downvote
    @album = Album.fetch.find(params[:id])
    if @album.downvoter_ids.include?(current_user.id)
      @album.downvoter_ids -= [current_user.id]
      @album.downvote_count -= 1
    else
      @album.downvoter_ids += [current_user.id]
      @album.downvote_count += 1
    end
    @album.save
    render :show
  end

  # TODO: this should redirect somewhere if current user doesn't own album!
  def edit
    @album = Album.includes(:images, :creator).find(params[:id])
    render :edit
  end

  def favorite
    @album = Album.fetch.find(params[:id])
    if @album.favoriting_user_ids.include?(current_user.id)
      @album.favoriting_user_ids -= [current_user.id]
    else
      @album.favoriting_user_ids += [current_user.id]
    end
    @album.save
    render :show
  end

  def index
    @albums = Album.fetch.load
    render :index
  end

  def new
    @album = Album.new
    5.times { @album.images.build }
    render :new
  end

  def show
    @album = Album.fetch.find(params[:id])
    render :show
  end

  def update
    @album = Album.find(params[:id])
    @images = @album.images
    if @album.update_attributes(album_params)
      redirect_to root_url
    else
      flash.now[:alerts] ||= []
      flash.now[:alerts] += @album.errors.full_messages
      flash.now[:alerts] += @album.images.map { |i| i.errors.full_messages }
      render :edit
    end

  end

  def upvote
    @album = Album.fetch.find(params[:id])
    if @album.upvoter_ids.include?(current_user.id)
      @album.upvoter_ids -= [current_user.id]
      @album.upvote_count -= 1
    else
      @album.upvoter_ids += [current_user.id]
      @album.upvote_count += 1
    end
    @album.save
    render :show
  end


  private

  def album_params
    params
      .require(:album)
      .permit(:description, :title,
        images_attributes: [:id, :description, :file, :title, :_destroy])
  end

  def new_album_params
    album_params.merge(creator_id: current_user.try(:id))
  end
end
