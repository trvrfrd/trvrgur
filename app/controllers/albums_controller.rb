class AlbumsController < ApplicationController
  def create
    begin
      ActiveRecord::Base.transaction do

        @album = Album.new(params[:album])
        @album.user_id = current_user ? current_user.id : nil

        @images = params[:images].map do |_,  image_params|
          next if image_params[:file].nil?
          Image.new(image_params)
        end.compact
        
        @images.each do |image|
          image.user_id = current_user ? current_user.id : nil
          image.save
        end

        @album.image_ids += @images.map(&:id)
        @album.save

        raise "invalid" unless @album.valid? && @images.all?(&:valid?)
      end
    rescue
      flash[:alerts] ||= []
      flash[:alerts] += @album.errors.full_messages
      flash[:alerts] += @images.map { |i| i.errors.full_messages }
      render :new
    else
      flash[:notices] ||= []
      flash[:notices] << "album created successfully" 
      redirect_to album_url(@album)
    end
  end

  def destroy
    
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
    @album = Album.find(params[:id])
    render :show
  end

  def update
    @album = Album.find(params[:id])
    begin
      ActiveRecord::Base.transaction do

        @album.update_attributes(params[:album])

        @album.images.each do |image|
          image.update_attributes(params[:images][image.id.to_s])
        end

        raise "invalid" unless @album.valid? && @album.images.all?(&:valid?)
      end
    rescue
      flash[:alerts] ||= []
      flash[:alerts] += @album.errors.full_messages
      flash[:alerts] += @album.images.map { |i| i.errors.full_messages }
      render :new
    else
      flash[:notices] ||= []
      flash[:notices] << "album updated successfully" 
      redirect_to album_url(@album)
    end

  end
end
