class HomeController < ApplicationController
  before_filter :login_required
  before_filter :password_changed
  
  def home
    # code goes here...
    if current_user.role == "admin"
      get_admin_data
    else
      get_parent_data
    end
  end
  
  def show
    # render whatever semi-static page the user is requesting
    if params[:page] == "home"
      get_parent_data if current_user.role == "guardian"
      get_admin_data if current_user.role == "admin"
    end
      render :action => params[:page]
  end
  
  private
    def get_parent_data
      @announcements = Announcement.all.recent(4)
      @students = Student.by_household(current_user.guardian.household.id)
    end
  
    def get_admin_data
      @announcements = Announcement.all.recent(4)
    end
    
    def password_changed
      if current_user.created_at == current_user.updated_at
        redirect_to change_password_path 
      end
      true
    end

end
