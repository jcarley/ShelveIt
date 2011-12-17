require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :username               => "jjones",
      :realname               => "Jay Jones",
      :email                  => "jjones@example.com",
      :password               => "secret_password",
      :password_confirmation  => "secret_password"
    }
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should edit an existing user" do
    user = User.create!(@attr)
    user.update_attributes(@attr.merge(:realname => "James Jones"))
    user.reload
    user.realname.should == "James Jones"
  end
  
  it "should require a username" do
    no_username_user = User.new(@attr.merge(:username => ""))
    no_username_user.should_not be_valid
  end
  
  it "should require a realname" do
    no_realname_user = User.new(@attr.merge(:realname => ""))
    no_realname_user.should_not be_valid
  end
  
  it "should require an email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should require a password" do
    no_password_user = User.new(@attr.merge(:password => ""))
    no_password_user.should_not be_valid
  end
  
  it "should reject usernames that are to long" do
    long_username_user = User.new(@attr.merge(:username => "a" * 26))
    long_username_user.should_not be_valid
  end
  
  it "should reject usernames that are to short" do
    short_username_user = User.new(@attr.merge(:username => "a" * 3))
    short_username_user.should_not be_valid
  end
  
  it "should reject realnames that are to long" do
    long_realname_user = User.new(@attr.merge(:realname => "a" * 76))
    long_realname_user.should_not be_valid
  end
  
  it "should reject realnames that are to short" do
    short_realname_user = User.new(@attr.merge(:realname => "a"))
    short_realname_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.bar.org first.last@foo.]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate usernames" do
    User.create!(@attr)
    user_with_duplicate_username = User.new(@attr)
    user_with_duplicate_username.should_not be_valid
  end
  
  it "should reject usernames identical up to case" do
    upcased_username = @attr[:username].upcase
    User.create!(@attr.merge(:username => upcased_username))
    user_with_duplicate_username = User.new(@attr)
    user_with_duplicate_username.should_not be_valid
  end
  
  describe "passwords" do
    
    before(:each) do
      @user = User.new(@attr)
    end
    
    it "should have a password attribute" do
      @user.should respond_to(:password)
    end
    
    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
    
    describe "password validations" do
      
      it "should require a password" do
        User.new(@attr.merge(:password => "", :password_confirmation => "")).
          should_not be_valid
      end
      
      it "should require a matching password confirmation" do
        User.new(@attr.merge(:password_confirmation => "invalid")).
          should_not be_valid
      end
      
      it "should reject short passwords" do
        short = "a" * 6
        User.new(@attr.merge(:passwords => short, :password_confirmation => short))
          .should_not be_valid
      end
      
      it "should reject long passwords" do
        long = "a" * 41
        User.new(@attr.merge(:passwords => long, :password_confirmation => long))
          .should_not be_valid
      end
      
    end
    
    describe "password encryption" do
      
      before(:each) do
        @user = User.create(@attr)
      end
      
      it "should have an encryption password attribute" do
        @user.should respond_to(:encrypted_password)
      end
      
      it "should set the encrypted password" do
        @user.encrypted_password.should_not be_blank
      end
      
      it "should have a salt" do
        @user.should respond_to(:salt)
      end
      
      describe "has_password? method" do
        
        it "should exist" do
          @user.should respond_to(:has_password?)
        end
        
        it "should return true if the passwords match" do
          @user.has_password?(@attr[:password]).should be_true
        end
        
        it "should return false if the passwords don't match" do
          @user.has_password?("invalid").should be_false
        end
        
      end
      
      describe "authentication method" do
        
        it "should exist" do
          User.should respond_to(:authenticate)
        end
        
        it "should return nil on username/password mismatch" do
          User.authenticate(@attr[:username], "wrong_password").should be_nil
        end
        
        it "should return nil for an email address with no user" do
          User.authenticate("bar@foo.com", @attr[:password]).should be_nil
        end
        
        it "should return the user on email/password match" do
          User.authenticate(@attr[:username], @attr[:password]).should == @user
        end
        
      end
      
    end
    
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

