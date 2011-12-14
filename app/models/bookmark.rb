class Bookmark < ActiveRecord::Base
  attr_accessible :user_id, :name, :url

  belongs_to :user

  url_regex = /(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:\/~\+#]*[\w\-\@?^=%&amp;\/~\+#])?/i
              
  validates :url, :presence => true,
                  :length => { :minimum => 10 },
                  :format => { :with => url_regex }
                  
  validates :name, :presence => true,
                   :length => { :maximum => 100 }
  
  scope :users_linked_to, lambda { |url| linked_to(url) }

  def liked_count
    Bookmark.users_linked_to(url).count
  end

  private

    def self.linked_to(url)
      where("url = '#{url}'")
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


#Select *
#From users u
  #Inner Join bookmarks b On u.user_id = b.user_id
#Where b.url = :url
