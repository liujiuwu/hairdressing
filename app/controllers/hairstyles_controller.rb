class HairstylesController < ApplicationController
  before_filter :set_current_page
  
  def index
    @hairstyles = Hairstyle.paginate(:page => params[:page],:order =>'id desc')
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @hairstyles }
    end
  end

  def show
    @hairstyle = Hairstyle.find(params[:id])
   # unless session["hairstyle_hits_#{@hairstyle.id}"]
      @hairstyle.increment!(:hits) 
      #session["hairstyle_hits_#{@hairstyle.id}"] = true
    #end
    respond_to do |format|
      format.html
      format.xml  { render :xml => @hairstyle }
    end
  end
  
  private
  def set_current_page
    current_page("page_hairstyles")
  end

end
