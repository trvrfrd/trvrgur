class SessionsController < ApplicationController
  before_filter :require_logged_in, :only => [:destroy]
  before_filter :require_logged_out, :except => [:destroy]

  def create
    @user = User.check_credentials(params[:identity], params[:password])
    if @user.nil?
      flash[:alerts] ||= []
      flash[:alerts] << "login unsuccesful, please try again"
      render :new
    else
      login_user!(@user)
      p "current user: #{current_user} "
      
      # DO SOMETHING USEFUL HERE
      redirect_to user_url(@user)
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
