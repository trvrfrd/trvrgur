class UsersController < ApplicationController
  before_action :require_logged_out, :only => [:create, :new]
  before_action :require_logged_in, :only => [:edit, :update, :destroy]

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to root_url
    else
      render :new
    end
  end

  # TODO: this should redirect somewhere if not destroying current user!!!
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to new_user_url
  end

  # TODO: this should redirect somewhere if not editing current user!!!
  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  # TODO: this should redirect somewhere if not updating current user!!!
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_url(@user)
    else
      render :edit
    end
  end


  private

  def user_params
    params.fetch(:user, {}).permit(:email, :username, :password)
  end
end
