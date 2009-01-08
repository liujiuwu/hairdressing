class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  before_filter :set_current_city
  helper :all

  def rescue_action_in_public(exception)
    logger.error("rescue_action_in_public executed")
    case exception
    when ActiveRecord::RecordNotFound, ::ActionController::RoutingError,::ActionController::UnknownAction
      logger.error("404 displayed")
      render(:file  => "#{RAILS_ROOT}/public/404.html",:status   => "404 Not Found")
    else
      logger.error("500 displayed")
      render(:file  => "#{RAILS_ROOT}/public/500.html",:status   => "500 Error")
    end
  end
  
  def local_request?
    false
  end
    
  def non_salon_user
    #    if logged_in?
    #      unless current_user.user_type=="1"
    #        redirect_to("/user/profile")
    #      end
    #    end
  end
  
  def current_page(page)
    @page = page
  end
  
  def current_area
    session[:area]
  end
  
  protect_from_forgery # :secret => '9fb922589f28065622a41efa0ebbef68'

  protected
  def check_permissions
    return true if current_user && current_user.is_admin
    return failed_check_permissions
  end

  def failed_check_permissions
    if RAILS_ENV != 'development'
      flash[:error] = 'It looks like you don\'t have permission to view that page.'
      redirect_back_or_default root_path and return true
    else
      render :text=><<-EOS
      <h1>It looks like you don't have permission to view this page.</h1>
      <div>
        Permissions: <br />
        Controller: #{controller_name}<br />
        Action: #{action_name}<br />
        Params: #{params.inspect}<br />
        Session: #{session.instance_variable_get("@data").inspect}<br/>
      </div>
      EOS
    end
    @level = []
    false
  end

  private 
  def find_salon_of_user
    @salon = current_user.salons.find(params[:salon_id])
  end
  
  def find_salon
    @salon = Salon.find(params[:id] || params[:salon_id])
  end
  
  def set_current_city
    session[:area] ||= Area.new(:name => '广东省 深圳市',:code => '4402')
    #    if logged_in? && except_set_current_city?
    #      session[:except_set_current_city] = false
    #      session[:area] = Area.new(:code => current_user.whereareyou,:name => Area.full_area_name(current_user.whereareyou)) unless current_user.whereareyou.blank?
    #    end
  end
  
  def except_set_current_city?
    session[:except_set_current_city] ||= false
    session[:except_set_current_city] == false
  end
end
