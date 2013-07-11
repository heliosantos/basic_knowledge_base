class UserSessionsController < ApplicationController
  skip_before_filter :require_login, :except => [:destroy]
  
  def new
    @user = User.new
  end
  
  def create
    if @user = login(params[:user][:email], params[:user][:password], true)
      redirect_to root_path
    else
      @user = User.new
      flash.now[:error] = "Wrong email and password combination." 
      render :action => "new"
    end
  end
  
  def destroy
    logout
    flash[:notice] = "You have sucessfully logged out"
    redirect_to login_path
  end
end
