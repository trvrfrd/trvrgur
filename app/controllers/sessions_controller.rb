class SessionsController < ApplicationController
  before_filter :require_logged_in, :only => [:destroy]
  before_filter :require_logged_out, :except => [:destroy]

  def create
    @user = User.check_credentials(params[:identity], params[:password])
    if @user.nil?
      flash[:notices] ||= []
      flash[:notices] << "Login unsuccesful, please try again."
      render :new
    else
      login_user!(@user)
      
      # DO SOMETHING USEFUL HERE
      render :json => @user
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
