require 'spec_helper'

describe BookmarksController do
  render_views

  before(:each) do
    @user = Factory(:user)
  end

  describe "GET 'index'" do
    it "should be successful" do
      test_sign_in @user
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      test_sign_in @user
      get 'new'
      response.should be_success
    end

    it "should render the 'new' page'" do
      test_sign_in @user
      get :new
      response.should render_template("new")
    end
  end

  describe "POST 'create'" do
    
    describe "failure" do
      
      before(:each) do
        @attr = { name: "", url: "" }
      end

      it "should render the 'new' page" do
        test_sign_in @user
        post :create, :bookmark => @attr
        response.should render_template('new')
      end

      it "should not create a bookmark" do
        lambda do
          test_sign_in @user
          post :create, :bookmark => @attr
        end.should_not change(@user.bookmarks, :count)
      end

    end

    describe "success" do
      
      before(:each) do
        @attr = { name: "MSN", url: "http://www.msn.com" }
      end

      it "should redirect to the 'index' page" do
        test_sign_in @user
        post :create, :bookmark => @attr
        response.should redirect_to(root_path)
      end

      it "should create a bookmark" do
        lambda do
          test_sign_in @user
          post :create, :bookmark => @attr
        end.should change(@user.bookmarks, :count)
      end

    end

  end

  describe "DELETE 'destroy'" do
    
    before(:each) do
      @bookmark = Factory(:bookmark)
    end

    it "should redirect to the index" do
      test_sign_in @user
      delete :destroy, :id => @bookmark
      response.should redirect_to root_path
    end

    it "should destroy the bookmark" do
      lambda do
        test_sign_in @user
        delete :destroy, :id => @bookmark
      end.should change(Bookmark, :count)
    end
  end
end
