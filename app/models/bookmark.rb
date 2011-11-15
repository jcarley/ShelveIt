class Bookmark < ActiveRecord::Base
  attr_accessible :user_id, :name, :url

  belongs_to :user

  url_regex = /(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:\/~\+#]*[\w\-\@?^=%&amp;\/~\+#])?/i
              
  validates :url, :presence => true,
                  :length => { :minimum => 10 },
                  :format => { :with => url_regex }
                  
  validates :name, :presence => true,
                   :length => { :maximum => 100 }
                   
  def initialized
    @date_saved = DateTime.now
  end
  
end


# == Schema Information
#
# Table name: bookmarks
#
#  id         :integer         not null, primary key
#  url        :string(255)
#  name       :string(255)
#  date_saved :datetime
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

