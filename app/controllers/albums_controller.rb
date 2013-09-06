class AlbumsController < ApplicationController
  before_filter :require_logged_in, :except => [:create, :index, :new, :show]
  def create
    begin
      ActiveRecord::Base.transaction do

        @album = Album.new(params[:album])
        @album.creator_id = current_user ? current_user.id : nil

        @images = params[:images].map do |_,  image_params|
          next if image_params[:file].nil?
          Image.new(image_params)
        end.compact
        
        @images.each do |image|
          image.uploader_id = current_user ? current_user.id : nil
          image.save
        end

        @album.image_ids += @images.map(&:id)
        @album.save

        raise "invalid" unless @album.valid? && @images.all?(&:valid?)
      end
    rescue
      flash.now[:alerts] ||= []
      flash.now[:alerts] += @album.errors.full_messages
      flash.now[:alerts] += @images.map { |i| i.errors.full_messages }
      render :new
    else
      flash[:notices] ||= []
      flash[:notices] << "album created successfully" 
      redirect_to album_url(@album)
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    flash[:notices] ||= []
    flash[:notices] << "album deleted successfully"
    redirect_to :back
  end

  def downvote
    @album = Album.find(params[:id])
    if @album.upvoting_user_ids.includes?(current_user.id)

    else
      UserAlbumVote.create(:user_id => )
      @album.downvotes += 1
      @album.save
      flash[:notices] ||= []
      flash[:notices] << "album downvoted"
    end  
    redirect_to album_url(@album)
  end

  def edit
    @album = Album.find(params[:id])
    render :edit    
  end

  def index
    @albums = Album.all
    render :index
  end

  def new
    @album = Album.new
    5.times { @album.images.build }
    render :new
  end

  def show
    @album = Album.includes(:comments => :author).find(params[:id])
    render :show
  end

  def update
    @album = Album.find(params[:id])
    begin
      ActiveRecord::Base.transaction do

        @album.update_attributes(params[:album])

        @album.images.each do |image|
          image_params = params[:images][image.id.to_s]
          if image_params[:_destroy]
            image.destroy
          else
            image.update_attributes(image_params)
          end
        end

        raise "invalid" unless @album.valid? && 
          @album.images.all? do |i|
            i.valid? || i.destroyed?
          end
      end
    rescue
      flash.now[:alerts] ||= []
      flash.now[:alerts] += @album.errors.full_messages
      flash.now[:alerts] += @album.images.map { |i| i.errors.full_messages }
      render :new
    else
      flash[:notices] ||= []
      flash[:notices] << "album updated successfully" 
      redirect_to album_url(@album)
    end

  end

  def upvote
    @album = Album.find(params[:id])
    @album.upvotes += 1
    @album.save
    flash[:notices] ||= []
    flash[:notices] << "album upvoted"
    redirect_to :back  
  end
end
