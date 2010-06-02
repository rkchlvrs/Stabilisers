require 'spec_helper'

describe User do
  
  # give the test some dummy values
  before(:each) do
    @attr = { :name => "Joe Blogs", :email => "joe@blogs.com" }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a name" do
    user_no_name = User.new(@attr.merge(:name => ""))
    user_no_name.should_not be_valid
  end
  
  it "should require an email" do
    user_no_email = User.new(@attr.merge(:email => ""))
    user_no_email.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 51
    user_long_name = User.new(@attr.merge(:name => long_name))
    user_long_name.should_not be_valid
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
    # watch for case issues
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    duplicate_user = User.new(@attr)
    duplicate_user.should_not be_valid
  end
  
end
