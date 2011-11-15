class RemoveDateSavedFromBookmark < ActiveRecord::Migration
  def self.up
    remove_column :bookmarks, :date_saved
  end

  def self.down
    add_column :bookmarks, :date_saved, :datetime
  end
end
