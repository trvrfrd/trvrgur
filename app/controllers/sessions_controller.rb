class SessionsController < ApplicationController
  before_filter :require_logged_in, :only => [:destroy]
  before_filter :require_logged_out, :except => [:destroy]

  def create
    @user = User.check_credentials(params[:identity], params[:password])
    if @user.nil?
      flash.now[:alerts] ||= []
      flash.now[:alerts] << "login unsuccesful, please try again"
      render :new
    else
      login_user!(@user)
      flash[:notices] ||= []
      flash[:notices] << "welcome back, #{@user.username}!"
      redirect_to albums_url
    end
  end

  def destroy
    logout_current_user!
    redirect_to new_session_url
  end

  def new
    render :new
  end
end
