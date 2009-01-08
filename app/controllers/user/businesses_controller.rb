class User::BusinessesController < ApplicationController
  before_filter :login_required,:set_current_page
  before_filter :find_salon_of_user
  before_filter :find_business,:except => [ :index,:new,:create ]
  layout 'user'
  
  def index
    @businesses = @salon.businesses.paginate(:page => params[:page],:order =>'created_at desc')

    respond_to do |format|
      format.html
      format.xml  { render :xml => @businesses }
    end
  end
  
  def new
    @business = Business.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @business }
    end
  end
  
  def create
    @business = @salon.businesses.build(params[:business])

    respond_to do |format|
      if @business.save
        flash[:notice] = 'Business was successfully created.'
        format.html { redirect_to(user_salon_businesses_url) }
        format.xml  { render :xml => @business, :status => :created, :location => @business }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @business.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @business.update_attributes(params[:business])
        flash[:notice] = 'Business was successfully updated.'
        format.html { redirect_to(user_salon_businesses_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @business.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @business.destroy

    respond_to do |format|
      format.html { redirect_to(user_salon_businesses_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def find_business
    @business = @salon.businesses.find(params[:id])
  end
  
  def set_current_page
    current_page("page_user")
  end
end
