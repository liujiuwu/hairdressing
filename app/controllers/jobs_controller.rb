class JobsController < ApplicationController
  before_filter :find_salon,:only => :index
  before_filter :set_current_page
  
  def index
    @jobs = @salon.jobs.paginate(:page => params[:page],:order =>'created_at desc')

    respond_to do |format|
      format.html
      format.xml  { render :xml => @jobs }
    end
  end
  
  def jobs
    @jobs = Job.paginate(:page => params[:page],:select => "jobs.*",:joins => "as jobs inner join salons as salons on jobs.salon_id = salons.id and salons.city like '#{current_area.code}%'",:per_page => 20,:order =>'created_at desc')
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @jobs }
    end
  end
  
  private
  def set_current_page
    current_page("page_jobs")
  end
end
