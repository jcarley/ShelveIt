require 'spec_helper'

describe LoginPresenter do
  
  before(:each) do
    @attr = {
      :username               => "jcarley",
      :realname               => "Jefferson carley",
      :email                  => "jcarley@example.com",
      :password               => "secret_password123",
      :password_confirmation  => "secret_password123"
    }
  end
  
  it "should have a user attribute" do
    login_presenter = LoginPresenter.new
    login_presenter.should respond_to(:user)
  end
  
  describe "authenticate method" do
  
    before(:each) do
      User.create(@attr)
    end
    
    it "should exist" do
      login_presenter = LoginPresenter.new
      login_presenter.should respond_to(:authenticate)
    end
    
    it "should return false on failed login attempts" do
      login_presenter = LoginPresenter.new :user_username => "jcarley", :user_password => "secret_password"
      login_presenter.authenticate.should be_false
    end
    
    it "should return true on successful login attempts" do
      login_presenter = LoginPresenter.new :user_username => "jcarley", :user_password => "secret_password123"
      login_presenter.authenticate.should be_true
    end
    
  end
  
end