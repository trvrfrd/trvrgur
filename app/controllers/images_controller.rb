class ImagesController < ApplicationController
  before_filter :require_logged_in, :only => [:edit, :update]

  def create
    @image = Image.new(params[:image])
    @image.user_id = current_user ? current_user.id : nil
    if @image.save
      redirect_to image_url(@image)
    else
      render :new
    end
    
  end

  def index
    @images = Image.all
    render :index
  end

  def new
    @image = Image.new
    render :new    
  end

  def show
    @image = Image.find(params[:id])
    render :show
  end

end
