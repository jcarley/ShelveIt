class BookmarksController < ApplicationController

  def index
    @bookmarks = Bookmark.paginate :page => params[:page]
  end

  def new
    @mark = Bookmark.new
  end
  
  def create
    @mark = Bookmark.new(params[:bookmark])
    if @mark.save
      flash[:notice] = "Bookmark added successfully."
      redirect_to :action => 'index'
    else
      render 'new'
    end
  end

end
