class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])
    if @user.save
      
      # DO SOMETHING USEFUL HERE
      render :json => @user
    else
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end
end
