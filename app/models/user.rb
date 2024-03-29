class User < ActiveRecord::Base
  attr_accessor   :password
  attr_accessible :username, :realname, :email, :password, :password_confirmation, :encrypted_password, :avatar

  has_many :bookmarks
  has_attached_file :avatar,
    :storage => :s3,
    :bucket => 'FinishFirstSoftware_RailsClass_ShelveIt',
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    }

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
  
  scope :who_is_linked_to, lambda { |url| users_linked_to_url(url) }
  
  def link_to(bookmark)
    return false unless bookmark.valid?

    bookmarks << bookmark
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
  
    def self.users_linked_to_url(url) 
      sql = %(id In (Select user_id From bookmarks Where url = '#{url}'))
      where(sql, :url => url)
    end

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
#  id                  :integer         not null, primary key
#  username            :string(255)
#  realname            :string(255)
#  email               :string(255)
#  encrypted_password  :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  salt                :string(255)
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

