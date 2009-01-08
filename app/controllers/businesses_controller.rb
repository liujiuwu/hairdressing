class BusinessesController < ApplicationController
  before_filter :find_salon,:only => :index
  before_filter :set_current_page

  def index
    @businesses = @salon.businesses.paginate(:page => params[:page],:order =>'created_at desc')

    respond_to do |format|
      format.html
      format.xml  { render :xml => @businesses }
    end
  end
  
  def businesses
    @businesses = Business.paginate(:page => params[:page],:select => "business.*",:joins => "as business inner join salons as salons on business.salon_id = salons.id and salons.city like '#{current_area.code}%'",:per_page => 20,:order =>'created_at desc')
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @businesses }
    end
  end
  
  private
  def set_current_page
    current_page("page_businesses")
  end
end
