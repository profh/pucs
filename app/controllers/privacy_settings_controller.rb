class PrivacySettingsController < ApplicationController

  # GET /privacy_settings/1
  # GET /privacy_settings/1.xml
  # def show
  #   @privacy_setting = PrivacySetting.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @privacy_setting }
  #   end
  # end

  # GET /privacy_settings/new
  # GET /privacy_settings/new.xml
  # def new
  #   @privacy_setting = PrivacySetting.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @privacy_setting }
  #   end
  # end

  # GET /privacy_settings/1/edit
  def edit
    @privacy_setting = PrivacySetting.find(params[:id])
  end

  # POST /privacy_settings
  # POST /privacy_settings.xml
  def create
    @privacy_setting = PrivacySetting.new(params[:privacy_setting])

    respond_to do |format|
      if @privacy_setting.save
        format.html { redirect_to(@privacy_setting, :notice => 'Privacy setting was successfully created.') }
        format.xml  { render :xml => @privacy_setting, :status => :created, :location => @privacy_setting }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @privacy_setting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /privacy_settings/1
  # PUT /privacy_settings/1.xml
  def update
    @privacy_setting = PrivacySetting.find(params[:id])

    respond_to do |format|
      if @privacy_setting.update_attributes(params[:privacy_setting])
        guardian = @privacy_setting.household.guardians.primary
        format.html { redirect_to guardian_path(guardian)  }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @privacy_setting.errors, :status => :unprocessable_entity }
      end
    end
  end
end
