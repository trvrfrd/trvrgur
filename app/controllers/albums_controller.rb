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
      redirect_to album_url(@album)
    end
  end

  def destroy
    
  end

  def edit
    
  end

  def index
    
  end

  def new
    @album = Album.new
    5.times { @album.images.build }
    render :new
  end

  def show
    
  end

  def update
    
  end
end
