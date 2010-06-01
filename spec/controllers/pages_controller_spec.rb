require 'spec_helper'

describe PagesController do
  # tell RSpec to load views too
  integrate_views

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    
    it "should have the correct title" do
      get 'about'
      response.should have_tag("title", "Stabilisers - About")
  end
  
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it "should have the correct title" do
      get 'home'
      response.should have_tag("title", "Stabilisers - Home")
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    
    it "should have the correct title" do
      get 'contact'
      response.should have_tag("title", "Stabilisers - Contact")
  end

end
