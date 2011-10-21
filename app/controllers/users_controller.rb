class UsersController < ApplicationController

  def index
    @user = User.new
  end
  
  def show
    @user = User.find params[:id]
  end

  def create
    @user = User.new params[:user]
    if @user.save
      flash[:notice] = "User #{@user.realname} was successfully created."
      redirect_to @user
    else
      flash[:error] = "Correct the errors below and try again"
      render :action => "new"
    end
  end

  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes params[:user]
      flash[:notice] = "User #{@user.realname} was successfully updated."
      redirect_to @user
    else
      flash[:error] = "Updating user #{@user.realname} failed."
      render :action => "edit"
    end
  end

  def login
    @user = User.authenticate params[:user][:username], params[:user][:password]
    
    if @user.nil?
      @user = User.new
      flash[:error] = "Invalid login and password combination"
      render :action => "index"
    else
      redirect_to @user
    end
    
  end

end
