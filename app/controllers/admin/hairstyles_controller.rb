class Admin::HairstylesController < ApplicationController
  before_filter :check_permissions

  layout 'admin'
  # GET /hairstyles
  # GET /hairstyles.xml
  def index
    @hairstyles = Hairstyle.paginate(:all,:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hairstyles }
    end
  end

  # GET /hairstyles/1
  # GET /hairstyles/1.xml
  def show
    @hairstyle = Hairstyle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hairstyle }
    end
  end

  # GET /hairstyles/new
  # GET /hairstyles/new.xml
  def new
    @hairstyle = Hairstyle.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hairstyle }
    end
  end

  # GET /hairstyles/1/edit
  def edit
    @hairstyle = Hairstyle.find(params[:id])
  end

  # POST /hairstyles
  # POST /hairstyles.xml
  def create
    @hairstyle = Hairstyle.new(params[:hairstyle])

    respond_to do |format|
      if @hairstyle.save
        flash[:notice] = 'Hairstyle was successfully created.'
        format.html { redirect_to(admin_hairstyles_url) }
        format.xml  { render :xml => @hairstyle, :status => :created, :location => @hairstyle }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hairstyle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hairstyles/1
  # PUT /hairstyles/1.xml
  def update
    @hairstyle = Hairstyle.find(params[:id])

    respond_to do |format|
      if @hairstyle.update_attributes(params[:hairstyle])
        flash[:notice] = 'Hairstyle was successfully updated.'
        format.html { redirect_to(admin_hairstyles_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @hairstyle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hairstyles/1
  # DELETE /hairstyles/1.xml
  def destroy
    @hairstyle = Hairstyle.find(params[:id])
    @hairstyle.destroy

    respond_to do |format|
      format.html { redirect_to(admin_hairstyles_url) }
      format.xml  { head :ok }
    end
  end
end
