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

  describe "POST 'create'" do
    
    describe "failure" do
    
      # ensure that the create action attempts to create a user
      before(:each) do
        # set up the attributes for the user
        @attr = { :name => "", :email => "", :password => "", :password_confirmation => "" }
        # create the user using the above attributes
        @user = Factory.build(:user, @attr)
        # ensure the call to User.new gets given the above user
        User.stub!(:new).and_return(@user)
        # define the message expectation - i.e., that the user.save method will return false with the above user
        @user.should_receive(:save).and_return(false)
      end
    
      it "should have the right title" do
        post :create, :user => @attr
        response.should have_tag("title", /sign up/i)
      end
      
      it "should render the 'new' page" do
          post :create, :user => @attr
          response.should render_template('new')
      end
    
    end
  
    describe "success" do
      
      before(:each) do
        @attr = { :name => "Example User", 
                  :email => "user@example.com", 
                  :password => "foobar", 
                  :password_confirmation => "foobar" }
        # we are simulating a saved user here so we use Factor(...)
        # rather than Factory.build(...)
        @user = Factory(:user, @attr)
        User.stub!(:new).and_return(@user)
        @user.should_receive(:save).and_return(true)
      end
      
      it "should redirect the user to the show user page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(@user))
      end
      
      it "should display the correct flash message" do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to stabilisers/i
      end
      
    end
  
  end
    
end
