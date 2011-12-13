class Bookmark < ActiveRecord::Base
  attr_accessible :user_id, :name, :url

  has_many :links
  has_many :users, :through => :links

  url_regex = /(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:\/~\+#]*[\w\-\@?^=%&amp;\/~\+#])?/i
              
  validates :url, :presence => true,
                  :length => { :minimum => 10 },
                  :format => { :with => url_regex }
                  
  validates :name, :presence => true,
                   :length => { :maximum => 100 }
                   
  def liked_count
    Bookmark.where("url = '#{url}'").count
  end
end


# == Schema Information
#
# Table name: bookmarks
#
#  id         :integer         not null, primary key
#  url        :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

