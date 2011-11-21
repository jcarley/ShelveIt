require 'spec_helper'

describe UsersController do
  render_views

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { username: "foo", 
                  realname: "Foo Bar", 
                  email: "", 
                  password: "", 
                  password_confirmation: "" }
      end

      it "should render 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

    end

    describe "success" do

      before(:each) do
        @attr = { username: "foobar", 
                  realname: "Foo Bar", 
                  email: "foo@example.com", 
                  password: "password", 
                  password_confirmation: "password" }
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count)
      end

      it "should sign in the user" do
        post :create, :user => @attr
        controller.should be_signed_in
      end

      it "should redirect to the bookmark page" do
        post :create, :user => @attr
        response.should redirect_to(bookmarks_path)
      end

    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'show'" do

    before(:each) do
      @user = Factory(:user)
    end

    it "should be successful" do
      test_sign_in @user
      get :show, :id => @user
      response.should be_success
    end

    it "should show the signed in user's information" do
      test_sign_in @user
      get :show, :id => @user
      assigns(:user).should == @user
    end
  end

  describe "GET 'edit'" do
    
    before(:each) do
      @user = Factory(:user)
      test_sign_in @user
    end

    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end

  end

  describe "POST 'update'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in @user
    end

    describe "failure" do

      before(:each) do
        @attr = { username: "", 
                  realname: "", 
                  email: "", 
                  password: "", 
                  password_confirmation: "" }
      end

      it "should render the 'edit' page" do
        put :update, :id => @user, :user => @attr
        response.should render_template("edit")
      end

    end

    describe "success" do
      
      before(:each) do
        @attr = { username: "foobar", 
                  realname: "Foo Bar", 
                  email: "foo@example.com", 
                  password: "password", 
                  password_confirmation: "password" }
      end

      it "should change the user's attributes" do
        put :update, :id => @user, :user => @attr
        user = assigns(:user)
        @user.reload
        @user.username.should == user.username
        @user.realname.should == user.realname
        @user.email.should == user.email
        @user.encrypted_password.should == user.encrypted_password
      end

    end
  end

end
