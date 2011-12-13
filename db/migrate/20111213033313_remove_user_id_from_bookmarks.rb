class RemoveUserIdFromBookmarks < ActiveRecord::Migration
  def self.up
    remove_column :bookmarks, :user_id
  end

  def self.down
    add_column :bookmarks, :user_id, :integer
  end
end
