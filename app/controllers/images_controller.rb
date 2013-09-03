class ImagesController < ApplicationController
  before_filter :require_logged_in, :only => [:edit, :update, :destroy]

  def create
    @image = Image.new(params[:image])
    @image.user_id = current_user ? current_user.id : nil
    if @image.save
      redirect_to image_url(@image)
    else
      render :new
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    redirect_to user_url(current_user)
  end

  def edit
    @image = Image.find(params[:id])
    render :edit
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

  def update
    @image = Image.find(params[:id])
    if @image.update_attributes(params[:image])
      flash[:notices] ||= []
      flash[:notices] << "image updated successfully"   
      redirect_to user_url(current_user)
    else
      render :edit
    end    
  end

end
