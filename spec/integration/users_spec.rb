require 'spec_helper'

describe "Users" do
  
  describe "signup" do
    
    describe "failure" do
      
      it "should not create a new user" do
        # we use lambda because that way we can check
        # the User :count
        lambda do
          visit signup_path
          click_button
          response.should render_template('users/new')
          response.should have_tag('div.errorExplanation')
        end.should_not change(User, :count)
      end
      
    end
    
    describe "success" do
      
      it "should create a new user" do
        
        lambda do
          visit signup_path
          fill_in :user_name,                     :with => "Example"         
          fill_in :user_email,                    :with => "user@example.com"
          fill_in :user_password,                 :with => "foobar"
          fill_in :user_password_confirmation,    :with => "foobar"
          click_button
          response.should render_template('users/show')
          response.should have_tag('div.flash_success')
        end.should change(User, :count)
        
      end
      
    end
    
  end
  
  
end
