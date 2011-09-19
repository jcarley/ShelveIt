class EarMark < ActiveRecord::Base
  attr_accessible :url, :name, :date_saved
  
  url_regex = /(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:\/~\+#]*[\w\-\@?^=%&amp;\/~\+#])?/i
  
  validates :url, :presence => true,
                  :length => { :minimum => 10 },
                  :format => { :with => url_regex }
                  
  validates :name, :presence => true,
                   :length => { :maximum => 100 }
  
end

# == Schema Information
#
# Table name: ear_marks
#
#  id         :integer         not null, primary key
#  url        :string(255)
#  name       :string(255)
#  date_saved :datetime
#  created_at :datetime
#  updated_at :datetime
#

