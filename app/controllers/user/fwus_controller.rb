class User::FwusController < ApplicationController
  before_filter :login_required,:set_current_page
  before_filter :find_salon_of_user
  before_filter :find_fwu,:except => [ :index,:new,:create ]
  layout 'user'

  def index
    @fwus = @salon.fwus.paginate(:page => params[:page],:order =>'created_at desc')

    respond_to do |format|
      format.html
      format.xml  { render :xml => @fwus }
    end
  end

  def new
    @fwu = Fwu.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @fwu }
    end
  end

  def create
    @fwu = @salon.fwus.build(params[:fwu])

    respond_to do |format|
      if @fwu.save
        flash[:notice] = 'Fwu was successfully created.'
        format.html { redirect_to(user_salon_fwus_url) }
        format.xml  { render :xml => @fwu, :status => :created, :location => @fwu }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fwu.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @fwu.update_attributes(params[:fwu])
        flash[:notice] = 'Fwu was successfully updated.'
        format.html { redirect_to(user_salon_fwus_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fwu.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @fwu.destroy

    respond_to do |format|
      format.html { redirect_to(user_salon_fwus_url) }
      format.xml  { head :ok }
    end
  end
  
  private 
  def find_fwu
    @fwu = @salon.fwus.find(params[:id])
  end
  
  def set_current_page
    current_page("page_user")
  end
end
