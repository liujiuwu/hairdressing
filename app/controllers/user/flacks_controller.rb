class User::FlacksController < ApplicationController
  before_filter :login_required,:set_current_page
  before_filter :find_salon_of_user
  before_filter :find_flack,:except => [ :index,:new,:create ]
  layout 'user'
  
  def index
    @flacks = @salon.flacks.paginate(:page => params[:page],:order =>'created_at desc')

    respond_to do |format|
      format.html
      format.xml  { render :xml => @flacks }
    end
  end
  
  def new
    @flack = Flack.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @flack }
    end
  end

  def create
    @flack = @salon.flacks.build(params[:flack])

    respond_to do |format|
      if @flack.save
        flash[:notice] = 'Flack was successfully created.'
        format.html { redirect_to(user_salon_flacks_url) }
        format.xml  { render :xml => @flack, :status => :created, :location => @flack }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @flack.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @flack.update_attributes(params[:flack])
        flash[:notice] = 'Flack was successfully updated.'
        format.html { redirect_to(user_salon_flacks_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @flack.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @flack.destroy

    respond_to do |format|
      format.html { redirect_to(user_salon_flacks_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def find_flack
    @flack = @salon.flacks.find(params[:id])
  end
  
  def set_current_page
    current_page("page_user")
  end
end
