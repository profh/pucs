class PasswordResetsController < ApplicationController
  
  # before_filter :require_no_user, :only => [:new, :create]
  # before_filter :require_user, :only => [:show, :edit, :update]
  # before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  
  def new
    render
  end
  
  def create
    @user = User.find_by_email(params[:email])  
    if @user  
      @user.deliver_password_reset_instructions!  
      flash[:notice] = "Instructions to reset your password have been emailed to you. " +  
      "Please check your email."  
      redirect_to root_url  
    else  
      flash[:error] = "No user was found with that email address."  
      render :action => :new  
    end
  end
  
  def edit 
    @user = current_user unless current_user.nil?
    render  
  end  

  def update  
    @user = current_user
    @user.password = params[:user][:password]  
    @user.password_confirmation = params[:user][:password_confirmation]  
    if @user.save  
      flash[:notice] = "Password successfully updated."  
      redirect_to home_path("home")  
    else  
      render :action => :edit  
    end  
  end
  
  private  
  def load_user_using_perishable_token
    unless current_user.nil?
      return true if current_user.created_at == current_user.updated_at
    end  
    
    @user = User.find_using_perishable_token(params[:id])  
    unless @user  
      flash[:error] = "We're sorry, but we could not locate your account. " +  
      "If you are having issues try copying and pasting the URL " +  
      "from your email into your browser or restarting the " +  
      "reset password process."  
      redirect_to root_url  
    end  
  end
end




