class GuardiansController < ApplicationController
  before_filter :login_required
  # GET /guardians
  # GET /guardians.xml
  def index
  # @guardians = Guardian.all
	@guardians = Guardian.all.paginate :page => params[:page], :per_page => 10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @guardians }
    end
  end

  # GET /guardians/1
  # GET /guardians/1.xml
  def show
    @guardian = Guardian.find(params[:id])
	  @students = @guardian.students
	  @household = @guardian.household
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @guardian }
    end
    
    authorize! :read, @guardian
  end

  # GET /guardians/new
  # GET /guardians/new.xml
  def new
    @guardian = Guardian.new
    authorize! :create, @guardian
    user = @guardian.build_user

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @guardian }
    end
  end

  # GET /guardians/1/edit
  def edit
    @guardian = Guardian.find(params[:id])
  end

  # POST /guardians
  # POST /guardians.xml
  def create
    @guardian = Guardian.new(params[:guardian])

    respond_to do |format|
      if @guardian.save
        format.html { redirect_to(@guardian, :notice => 'Guardian was successfully created.') }
        format.xml  { render :xml => @guardian, :status => :created, :location => @guardian }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @guardian.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /guardians/1
  # PUT /guardians/1.xml
  def update
    @guardian = Guardian.find(params[:id])

    respond_to do |format|
      if @guardian.update_attributes(params[:guardian])
        format.html { redirect_to(@guardian, :notice => 'Guardian was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @guardian.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /guardians/1
  # DELETE /guardians/1.xml
  def destroy
    @guardian = Guardian.find(params[:id])
    authorize! :destroy, @guardian
    # @guardian.destroy
    @guardian.make_inactive

    respond_to do |format|
      format.html { redirect_to(guardians_url) }
      format.xml  { head :ok }
    end
  end
end
