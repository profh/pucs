class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      flash[:notice] = "The new family has been created and an email has been sent with their information."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def update
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated."
      redirect_to account_url
    else
      render :action => :edit
    end
  end
  
  def destroy
  	@user=User.find(params[:id])
  	@user.make_inactive
  	redirect_to home_path("home")
  
end
