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
    if @album.downvoter_ids.include?(current_user.id)
      @album.downvoter_ids -= [current_user.id]
      @album.downvote_count -= 1
      @album.save
      flash[:notices] ||= []
      flash[:notices] << "downvote retracted"
    else
      @album.downvoter_ids += [current_user.id]
      @album.downvote_count += 1
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

  def favorite
    @album = Album.find(params[:id])
    flash[:notices] ||= []
    if @album.favoriting_user_ids.include?(current_user.id)
      @album.favoriting_user_ids -= [current_user.id]
      flash[:notices] << "album added to favorites"     
    else
      @album.favoriting_user_ids += [current_user.id]
      flash[:notices] << "album removed from favorites"         
    end
    @album.save 
    redirect_to album_url(@album)    
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
    if @album.upvoter_ids.include?(current_user.id)
      @album.upvoter_ids -= [current_user.id]
      @album.upvote_count -= 1
      @album.save
      flash[:notices] ||= []
      flash[:notices] << "upvote retracted"
    else
      @album.upvoter_ids += [current_user.id]
      @album.upvote_count += 1
      @album.save
      flash[:notices] ||= []
      flash[:notices] << "album upvoted"
    end  
    redirect_to album_url(@album)
  end
end
