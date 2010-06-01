require 'spec_helper'

describe PagesController do
  # tell RSpec to load views too
  integrate_views
  
  before(:each) do
    @base_title = "Stabilisers - "
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    
    it "should have the correct title" do
      get 'about'
      response.should have_tag("title", @base_title + "About")
    end
  end
  
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it "should have the correct title" do
      get 'home'
      response.should have_tag("title", @base_title + "Home")
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    
    it "should have the correct title" do
      get 'contact'
      response.should have_tag("title", @base_title + "Contact")
    end
  end

end
