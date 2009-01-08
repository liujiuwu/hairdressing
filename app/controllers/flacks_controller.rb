class FlacksController < ApplicationController
  before_filter :find_salon,:only => [:index,:show]
  before_filter :set_current_page
  
  def index
    @flacks = @salon.flacks.paginate(:page => params[:page],:order =>'created_at desc')

    respond_to do |format|
      format.html
      format.xml  { render :xml => @flacks }
    end
  end
  
  def flacks
    @flacks = Flack.paginate(:page => params[:page],:select => "flacks.*",:joins => "as flacks inner join salons as salons on flacks.salon_id = salons.id and salons.city like '#{current_area.code}%'",:per_page => 20,:order =>'created_at desc')
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @flacks }
    end
  end
  
  private
  def set_current_page
    current_page("page_flacks")
  end
end
