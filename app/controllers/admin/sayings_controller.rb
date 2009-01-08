class Admin::SayingsController < ApplicationController
  before_filter :check_permissions

  layout 'admin'
  def index
    @sayings = Saying.paginate(:all,:page => params[:page],:order =>'created_at desc')

    respond_to do |format|
      format.html
      format.xml  { render :xml => @sayings }
    end
  end

  def destroy
    @saying = Saying.find(params[:id])
    @saying.destroy

    respond_to do |format|
      format.html { redirect_to(admin_sayings_url) }
      format.xml  { head :ok }
    end
  end

end
