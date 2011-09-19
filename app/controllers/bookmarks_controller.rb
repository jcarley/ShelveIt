class BookmarksController < ApplicationController
  def home
  end

  def add
    @mark = EarMark.new
  end

end
