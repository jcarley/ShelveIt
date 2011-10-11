class User < ActiveRecord::Base
  attr_accessor   :password
  attr_accessible :username, :realname, :email, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :username,    :presence => true,
                          :length => { :within => 4..25 },
                          :uniqueness => { :case_sensitive => false }
                          
  validates :realname,    :presence => true,
                          :length => { :within => 2..75 }
  
  validates :email,       :presence => true,
                          :length => { :within => 10..75 },
                          :format => { :with => email_regex }
                          
  validates :password,    :presence => true,
                          :confirmation => true,
                          :length => { :within => 7..40 }
                          


  
end

# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  username           :string(255)
#  realname           :string(255)
#  email              :string(255)
#  encrypted_password :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

