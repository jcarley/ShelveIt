class UsersController < ApplicationController

  before_filter :authenticate, :only => [:index, :show, :edit, :update]
  before_filter :correct_user, :only => [:show, :edit, :update]

  # Shows profile information for user
  def show
    @user = User.find params[:id]
  end

  def create
    @user = User.new params[:user]
    if @user.save
      sign_in @user
      flash[:notice] = "User #{@user.realname} was successfully created."
      redirect_to bookmarks_path
    else
      flash.now[:error] = "Correct the errors below and try again"
      render :action => "new"
    end
  end

  def new
    @user = User.new
  end
 
  # Gets user profile information
  def edit
    @user = User.find(params[:id])
  end
 
  # Updates user profile information
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes params[:user]
      flash[:notice] = "User #{@user.realname} was successfully updated."
      redirect_to @user
    else
      flash.now[:error] = "Updating user #{@user.realname} failed."
      render :action => "edit"
    end
  end

end
