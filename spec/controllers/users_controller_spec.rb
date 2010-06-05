require 'spec_helper'

describe UsersController do
  integrate_views

  describe "GET 'show'" do
    
    before(:each) do
      # create the user defined in spec/factories.rb
      @user = Factory(:user)
      # force User.find(:params[:id]) to find @user
      User.stub!(:find, @user.id).and_return(@user)
    end
    
    it "should be successful" do
      # below could be replaced with :id => @user.id
      get :show, :id => @user
      response.should be_success
    end
    
    it "should have the correct title" do
      get :show, :id => @user
      response.should have_tag("title", /#{@user.name}/) 
    end
    
    it "should include the users name" do
      get :show, :id => @user
      response.should have_tag(".username", /#{@user.name}/)
    end
    
    it "should have a profile image" do
      get :show, :id => @user
      response.should have_tag("img.gravatar")
    end
    
  end

  describe "GET 'new'" do
    
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the correct title" do
      get 'new'
      response.should have_tag("title", /Sign Up/)
    end
  end
end
