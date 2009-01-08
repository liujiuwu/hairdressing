class SalonsController < ApplicationController
  before_filter :login_required,:only => :vote
  before_filter :set_current_page
  before_filter :find_salon,:except => [ :index,:search ]

  def index
    @salons = Salon.paginate(:page => params[:page],:conditions =>["city like ?",current_area.code+"%"],:order =>'id desc')
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @salons }
    end
  end
  
  def search
    query = params[:query] || ""
    @salons = Salon.paginate(:page => params[:page],:conditions =>["name like ? and city like ?","%"+query.strip+"%",current_area.code+"%"],:order =>'id desc')
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @salons }
    end
  end
  
  def vote
    unless @salon.voted_by_user?(current_user)
      @salon.votes << Vote.new(:vote => true,:user_id => current_user.id)
    end
    respond_to do |format|
      format.html
      format.js do
        render :update do |page|
          page.replace_html "salon_vote_#{@salon.id}", @salon.votes_for
          page.replace_html "salon_vote_link_#{@salon.id}", '<span class="green dig_text">已推荐</span>'
        end
      end
    end
  end
  
  def show
    unless session["salon_hits_#{@salon.id}"]
        @salon.increment!(:hits)
        session["salon_hits_#{@salon.id}"] = true
    end
    
    @comments = @salon.comments.paginate(:page => params[:page],:per_page => 10,:order =>'created_at desc')
    respond_to do |format|
      format.html
      format.xml  { render :xml => @salon }
    end
  end
  
  private
  def set_current_page
    current_page("page_salons")
  end
end
