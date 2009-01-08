class FwusController < ApplicationController
  before_filter :find_salon
  before_filter :set_current_page
  
  def index
    @fwus = @salon.fwus.paginate(:page => params[:page],:order =>'created_at desc')
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @salons }
    end
  end
  
  private 
  def find_salon
    @salon = Salon.find(params[:salon_id])
  end
  
  private
  def set_current_page
    current_page("page_salons")
  end
end
