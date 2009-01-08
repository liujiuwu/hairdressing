class UsersController < ApplicationController
  before_filter :login_required, :except => [ :new, :create,:show ]
  before_filter :set_current_page
  layout 'user'
  def new
    render :layout => 'application'
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
    else
      render :action => 'new',:layout => 'application'
    end
  end
  
  def show
    @user = User.find_by_login(params[:name])
    if @user.nil? 
      raise ActiveRecord::RecordNotFound
    end
    render :layout => 'user_info'
  end
  
  def edit
    @user = User.find(current_user.id)
  end
  
  def update
    @user = User.find(current_user.id)

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = '个人资料修改成功。'
        format.html { redirect_to('/user/profile') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private
  def set_current_page
    current_page("page_user")
  end

end
