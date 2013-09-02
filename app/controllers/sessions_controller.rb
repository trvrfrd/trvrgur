class SessionsController < ApplicationController
  before_filter :require_logged_in, :only => [:destroy]
  before_filter :require_logged_out, :except => [:destroy]

  def create
    flash[:notices] ||= []
    @user = User.check_credentials(params[:username], params[:password])
    if @user.nil?
      flash[:notices] << "Login unsuccesful, please try again."
      render :new
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
    @user = User.new
    render :new
  end
end
