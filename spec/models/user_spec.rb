require 'spec_helper'

describe User do
  
  # give the test some dummy values
  before(:each) do
    @attr = { 
      :name => "Joe Blogs", 
      :email => "joe@blogs.com",
      :password => "foobar",
      :password_conf => "foobar" 
    }
  end

  describe "name and email validations" do

    it "should create a new instance given valid attributes" do
      User.create!(@attr)
    end
  
    it "should require a name" do
      user_no_name = User.new(@attr.merge(:name => ""))
      user_no_name.should_not be_valid
    end

    it "should reject names that are too long" do
      long_name = "a" * 51
      user_long_name = User.new(@attr.merge(:name => long_name))
      user_long_name.should_not be_valid
    end
  
    it "should require an email" do
      user_no_email = User.new(@attr.merge(:email => ""))
      user_no_email.should_not be_valid
    end
 
    # more of a sanity check than anything else
    it "should reject invalid email addresses" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        user_invalid_email = User.new(@attr.merge(:email => address))
        user_invalid_email.should_not be_valid
      end
    end
  
    # more of a sanity check than anything else
    it "should accept valid email addresses" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        user_valid_email = User.new(@attr.merge(:email => address))
        user_valid_email.should be_valid
      end
    end
  
    it "should reject duplicate email addresses" do
      User.create!(@attr)
      duplicate_user = User.new(@attr)
      duplicate_user.should_not be_valid
    end
  
  end

  describe "password validations" do
    
    it "should require a valid password" do
      User.new(@attr.merge(:password => "")).
        should_not be_valid
    end
    
    it "should have a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end
    
    it "should reject short passwords" do
      short_password = "a" * 5
      hash = @attr.merge(:password => short_password, :password_conf => short_password)
      User.new(hash).should_not be_valid
    end
  
    it "should reject long passwords" do
      long_password = "a" * 41
      hash = @attr.merge(:password => long_password, :password_conf => long_password)
      User.new(hash).should_not be_valid
    end

  end  
  
  describe "password encryption" do
    
    # create and save a user (using create!)
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should save the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do
      
      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
      
    end
    
    describe "authenticate method" do
      
      it "should return nil on email/password mismatch" do
        user_wrong_password = User.authenticate(@attr[:email], "wrongpass")
        user_wrong_password.should be_nil
      end
      
      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end
      
      it "should return the user on correct password/email" do
        valid_user = User.authenticate(@attr[:email], @attr[:password])
        valid_user.should == @user
      end
  
    end
    
  end    
  
end
