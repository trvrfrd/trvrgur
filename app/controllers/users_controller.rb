class UsersController < ApplicationController
  before_filter :require_logged_out, :except => [:show]

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

  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.find(params[:id])
    render :show    
  end
end
