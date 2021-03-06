class SessionsController < ApplicationController
  before_action :require_logged_in, :only => [:destroy]
  before_action :require_logged_out, :except => [:destroy]

  def create
    @user = User.check_credentials(params[:identity], params[:password])
    if @user.nil?
      flash[:alerts] ||= []
      flash[:alerts] << "incorrect username or password, please try again"
      redirect_to new_session_url
    else
      login_user!(@user)
      redirect_to root_url
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
