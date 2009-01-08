class IndexController < ApplicationController
  before_filter :set_current_page
  def index
    @salons = Salon.find(:all,:conditions =>["city like ?",current_area.code+"%"],:order => 'salons.created_at desc',:limit => 8)
  end
  
  private
  def set_current_page
    current_page("page_home")
  end
  
end
