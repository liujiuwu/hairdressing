class Admin::SalonsController < ApplicationController
  before_filter :check_permissions
  layout "admin"

  def index
    @salons = Salon.paginate(:page => params[:page],:order =>'created_at desc')

    respond_to do |format|
      format.html  {render}
      format.xml  { render :xml => @salons }
    end
  end


  def destroy
    @salon = Salon.find(params[:id])
    @salon.destroy

    respond_to do |format|
      format.html { redirect_to(admin_salons_url) }
      format.xml  { head :ok }
    end
  end
end
