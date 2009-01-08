class User::InfosController < ApplicationController
  before_filter :login_required,:set_current_page
  before_filter :find_info,:except => [ :index,:new,:create ]
  layout 'user'

  def index
    @infos = current_user.infos.paginate(:page => params[:page],:order =>'created_at desc')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @infos }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @info }
    end
  end

  def new
    @info = Info.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @info }
    end
  end

  def create
    @info = current_user.infos.build(params[:info])
    #@info.tag_list = params[:tags]

    respond_to do |format|
      if @info.save
        flash[:notice] = 'User::Info was successfully created.'
        format.html { redirect_to(user_infos_url) }
        format.xml  { render :xml => @info, :status => :created, :location => @info }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @info.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @info.update_attributes(params[:info])
        flash[:notice] = 'User::Info was successfully updated.'
        format.html { redirect_to(user_infos_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @info.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @info.destroy

    respond_to do |format|
      format.html { redirect_to(user_infos_url) }
      format.xml  { head :ok }
    end
  end

  private
  def find_info
    @info = Info.find(params[:id])
  end

  def set_current_page
    current_page("page_user")
  end
end
