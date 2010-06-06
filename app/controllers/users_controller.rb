class UsersController < ApplicationController
  def new
    @user = User.new
    @title = "Sign Up"
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def create
    # :user is the hash of values needed to create a new user
    @user = User.new(params[:user])
    if @user.save
      # handle a successful save
      flash[:success] = "Welcome to Stabilisers"
      redirect_to @user
    else
      @title = "Sign up"
      # reset the password
      @user.password = nil
      render 'new'
    end
  end
  
end
