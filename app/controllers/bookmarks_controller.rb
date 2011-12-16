class BookmarksController < ApplicationController
  
  before_filter :authenticate, :only => [:index, :new, :create, :destroy]

  def index
    @bookmarks = current_user.bookmarks.paginate :page => params[:page]
  end

  def show
    @bookmark = Bookmark.find_by_id params[:id]
    @users = User.who_is_linked_to( @bookmark.url ).paginate :page => params[:page], :per_page => 10
  end

  def new
    @mark = Bookmark.new
  end
  
  def create
    @mark = Bookmark.new(params[:bookmark])

    current_user.link_to( @mark )

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
