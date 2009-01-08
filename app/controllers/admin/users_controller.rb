class Admin::UsersController < ApplicationController
  before_filter :check_permissions

  layout 'admin'

  def index
    @users = User.paginate(:all,:page => params[:page],:order =>'created_at desc')

    respond_to do |format|
      format.html
      format.xml  { render :xml => @users }
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(admin_users_url) }
      format.xml  { head :ok }
    end
  end

end
