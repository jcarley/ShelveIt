class User < ActiveRecord::Base
  attr_accessor   :password
  attr_accessible :username, :realname, :email, :password, :password_confirmation, :encrypted_password

  has_many :links
  has_many :bookmarks, :through => :links

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

  before_save :encrypt_password
  
  def link_to(bookmark)
    return false unless bookmark.valid?

    link = links.create!
    link.bookmark = bookmark
    link.save
  end

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(submitted_username, submitted_password)
    user = find_by_username submitted_username
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  private
  
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt password
    end
    
    def encrypt(string)
      secure_hash "#{salt}--#{string}"
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest string
    end
    
    def make_salt
      secure_hash "#{Time.now.utc}--#{password}"
    end

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
#  salt               :string(255)
#

