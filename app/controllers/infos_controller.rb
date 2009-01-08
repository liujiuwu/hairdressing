class InfosController < ApplicationController
  before_filter :set_current_page

  def index
    @infos = Info.paginate(:page => params[:page],:conditions =>["city like ? or city is null",current_area.code+"%"],:order =>'created_at desc')

    respond_to do |format|
      format.html
      format.xml  { render :xml => @infos }
    end
  end

   def show
    @info = Info.find(params[:id])
    
    unless session["info_hits_#{@info.id}"]
      @info.increment!(:hits)
      session["info_hits_#{@info.id}"] = true
    end

     respond_to do |format|
      format.html
      format.xml  { render :xml => @info }
    end
  end

  private
  def set_current_page
    current_page("page_infos")
  end
end
