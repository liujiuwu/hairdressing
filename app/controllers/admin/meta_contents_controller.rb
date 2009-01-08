class Admin::MetaContentsController < ApplicationController
  before_filter :check_permissions

  layout 'admin'
  # GET /meta_contents
  # GET /meta_contents.xml
  def index
    @meta_contents = MetaContent.paginate(:all,:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @meta_contents }
    end
  end

  # GET /meta_contents/1
  # GET /meta_contents/1.xml
  def show
    @meta_content = MetaContent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @meta_content }
    end
  end

  # GET /meta_contents/new
  # GET /meta_contents/new.xml
  def new
    @meta_content = MetaContent.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @meta_content }
    end
  end

  # GET /meta_contents/1/edit
  def edit
    @meta_content = MetaContent.find(params[:id])
  end

  # POST /meta_contents
  # POST /meta_contents.xml
  def create
    @meta_content = MetaContent.new(params[:meta_content])

    respond_to do |format|
      if @meta_content.save
        flash[:notice] = 'MetaContent was successfully created.'
        format.html { redirect_to(admin_meta_contents_url) }
        format.xml  { render :xml => @meta_content, :status => :created, :location => @meta_content }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @meta_content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /meta_contents/1
  # PUT /meta_contents/1.xml
  def update
    @meta_content = MetaContent.find(params[:id])

    respond_to do |format|
      if @meta_content.update_attributes(params[:meta_content])
        flash[:notice] = 'MetaContent was successfully updated.'
        format.html { redirect_to(admin_meta_contents_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @meta_content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /meta_contents/1
  # DELETE /meta_contents/1.xml
  def destroy
    @meta_content = MetaContent.find(params[:id])
    @meta_content.destroy

    respond_to do |format|
      format.html { redirect_to(admin_meta_contents_url) }
      format.xml  { head :ok }
    end
  end
end
