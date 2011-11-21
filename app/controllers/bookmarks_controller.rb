class BookmarksController < ApplicationController
  
  before_filter :authenticate, :only => [:index, :new, :create, :destroy]

  def index
    @bookmarks = current_user.bookmarks.paginate :page => params[:page]
  end

  def new
    @mark = Bookmark.new
  end
  
  def create
    @mark = Bookmark.new(params[:bookmark])

    current_user.bookmarks << @mark

    if @mark.save
      flash[:notice] = "Bookmark added successfully."
      redirect_to :action => 'index'
    else
      render 'new'
    end
  end

  def destroy
    @bookmark = Bookmark.delete(params[:id])
    redirect_to :action => "index"
  end

end
