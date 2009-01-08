class User::SalonsController < ApplicationController
  before_filter :login_required,:set_current_page,:non_salon_user
  before_filter :find_salon,:except => [ :index,:new,:create ]
  layout "user"

  def index
    @salons = current_user.salons.paginate(:page => params[:page],:order =>'id desc')

    respond_to do |format|
      format.html  {render}
      format.xml  { render :xml => @salons }
    end
  end

  def new
    @salon = Salon.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @salon }
    end
  end

  def create
    @salon = Salon.new(params[:salon])
    @salon.user = current_user
    respond_to do |format|
      if @salon.save
        flash[:notice] = 'Salon was successfully created.'
        format.html { redirect_to(user_salons_url) }
        format.xml  { render :xml => @salon, :status => :created, :location => @salon }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @salon.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @salon.update_attributes(params[:salon])
        flash[:notice] = 'Salon was successfully updated.'
        format.html { redirect_to(user_salons_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @salon.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @salon.destroy

    respond_to do |format|
      format.html { redirect_to(user_salons_url) }
      format.xml  { head :ok }
    end
  end

  private
  def find_salon
    @salon = current_user.salons.find(params[:id])
  end

  def set_current_page
    current_page("page_user")
  end
end
