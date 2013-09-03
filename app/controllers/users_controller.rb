class UsersController < ApplicationController
  before_filter :require_logged_out, :only => [:create, :new]
  before_filter :require_logged_in, :only => [:edit, :update]

  def create
    @user = User.new(params[:user])
    if @user.save
      
      # REDIRECT SOMEWHERE USEFUL HERE
      login_user!(@user)
      redirect_to user_url(@user)
    else
      render :new
    end
  end

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

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      
      # REDIRECT SOMEWHERE USEFUL HERE
      flash[:notices] ||= []
      flash[:notices] << "account updated successfully"      
      redirect_to user_url(@user)
    else
      render :edit
    end
  end
end
