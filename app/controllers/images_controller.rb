class ImagesController < ApplicationController
  before_action :require_logged_in, :only => [:edit, :update, :destroy]

  def create
    @image = Image.new(image_params)
    @image.uploader_id = current_user ? current_user.id : nil
    if @image.save
      flash[:notices] ||= []
      flash[:notices] << "image uploaded successfully"
      redirect_to image_url(@image)
    else
      flash.now[:alerts] ||= []
      flash.now[:alerts] += @image.errors.full_messages
      render :new
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    flash[:notices] ||= []
    flash[:notices] << "image deleted successfully"
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
    @image = Image.find(image_params)
    if @image.update_attributes(params[:image])
      flash[:notices] ||= []
      flash[:notices] << "image updated successfully"
      redirect_to image_url(@image)
    else
      flash.now[:alerts] ||= []
      flash.now[:alerts] += @image.errors.full_messages
      render :edit
    end
  end


  private

  def image_params
    params.fetch(:image, {}).permit(:description, :title, :uploader_id, :album_id, :file)
  end
end
