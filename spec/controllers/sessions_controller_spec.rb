require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do

    describe "failure" do
      
      before(:each) do
        @attr = { :email => "", :password => "" }
      end

      it "should re-render the new page" do
        post :create, :session => @attr
        response.should render_template('new')
      end

    end

  end

end
