require 'spec_helper'

describe UsersController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "should be successful" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  # describe "GET 'login'" do
  #     it "should be successful" do
  #       post 'login'
  #       response.should be_success
  #     end
  #   end

end
