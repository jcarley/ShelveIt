class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate params[:session][:username], 
                             params[:session][:password]
    
    if user.nil?
      flash.now[:error] = "Invalid login and password combination"
      render "new"
    else
      sign_in user
      redirect_to users_path( user )
    end
    
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
