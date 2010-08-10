class HouseholdsController < ApplicationController
  before_filter :login_required
  # GET /households
  # GET /households.xml
  def index
    # @households = Household.all
    if current_user.admin?
      @households = Household.active.by_guardians.paginate :page => params[:page], :per_page => 12
    else
      @households = Household.active.is_public.by_guardians.paginate :page => params[:page], :per_page => 12
    end
    
 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @households }
    end
  end

  # GET /households/1
  # GET /households/1.xml
  def show
    @household = Household.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @household }
    end
  end

  # GET /households/new
  # GET /households/new.xml
  def new
    @household = Household.new
    student = @household.students.build
    2.times { guardian = @household.guardians.build; user = guardian.build_user }
    
    authorize! :create, @household

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @household }
     
    end
  end

  # GET /households/1/edit
  def edit
    @household = Household.find(params[:id])
    @privacy_setting = @household.privacy_setting
    authorize! :update, @household
  end

  # POST /households
  # POST /households.xml
  def create
    @household = Household.new(params[:household])  
    authorize! :create, @household

    respond_to do |format|
      if @household.save
        # once the household is created, create default privacy settings
        @privacy_setting = PrivacySetting.new
        @privacy_setting.household_id = @household.id
        @privacy_setting.save
        
        # send an email to the new user with account info
        @recipient = @household.guardians.by_primary.first
        PostOffice.deliver_profile_added(@recipient)
        
        format.html { redirect_to(home_path("home"), :notice => 'Household was successfully created.') }
        format.xml  { render :xml => @household, :status => :created, :location => @household }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @household.errors, :status => :unprocessable_entity }
        
      end
    end
  end

  # PUT /households/1
  # PUT /households/1.xml
  def update
    @household = Household.find(params[:id])
    authorize! :update, @household
    
    #Ziv Piper was coding here
    respond_to do |format|
      if @household.update_attributes(params[:household])
        guardian =@household.guardians.primary
        format.html { redirect_to guardian_path(guardian) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @household.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /households/1
  # DELETE /households/1.xml
  def destroy
    @household = Household.find(params[:id])
    #@household.destroy
    authorize! :destroy, @household
    @household.make_inactive

    respond_to do |format|
      format.html { redirect_to(households_url) }
      format.xml  { head :ok }
    end
  end
  
# def random_password
  	#@password =  /^\w{10}[a-z][A-Z]$/
  	#require 'active_support/secure_random'
#	@password = ActiveSupport::SecureRandom.hex(5)
	
	#puts  "#{password}"
# end
  
end
