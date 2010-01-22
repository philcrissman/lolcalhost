class UsersController < ApplicationController
  before_filter :must_be_logged_out, :only => [:new, :create]
  before_filter :must_be_logged_in, :only => [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
  end
  
  def edit
    unless current_user.root?
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end
  
  def update
    unless current_user.root?
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end
end
