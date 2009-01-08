class User::IndexController < ApplicationController
  before_filter :login_required,:set_current_page,:non_salon_user
  layout 'user'
  def index
  end
  
  private
  def set_current_page
    current_page("page_user")
  end
end
