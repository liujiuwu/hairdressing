class User::JobsController < ApplicationController
  before_filter :login_required,:set_current_page
  before_filter :find_salon_of_user
  before_filter :find_job,:except => [ :index,:new,:create ]
  layout 'user'
  
  def index
    @jobs =  @salon.jobs.paginate(:page => params[:page],:order =>'created_at desc')

    respond_to do |format|
      format.html
      format.xml  { render :xml => @jobs }
    end
  end

  def new
    @job = Job.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @job }
    end
  end

  def create
    @job = @salon.jobs.build(params[:job])

    respond_to do |format|
      if @job.save
        flash[:notice] = 'Job was successfully created.'
        format.html { redirect_to(user_salon_jobs_url) }
        format.xml  { render :xml => @job, :status => :created, :location => @job }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job.update_attributes(params[:job])
        flash[:notice] = 'Job was successfully updated.'
        format.html { redirect_to(user_salon_jobs_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @job.destroy

    respond_to do |format|
      format.html { redirect_to(user_salon_jobs_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def find_job
    @job = @salon.jobs.find(params[:id])
  end
  
  def set_current_page
    current_page("page_user")
  end
end
