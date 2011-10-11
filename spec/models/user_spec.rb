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

