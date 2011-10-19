class UsersController < ApplicationController

  def index
    @presenter = LoginPresenter.new
  end

  def create
  end

  def new
  end

  def login
    @presenter = LoginPresenter.new(params[:presenter])
    redirect_to :action => "new" if @presenter.authenticate
  end

end
