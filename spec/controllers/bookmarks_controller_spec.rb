require 'spec_helper'

describe BookmarksController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'add'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

end
