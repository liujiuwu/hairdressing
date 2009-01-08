class Admin::TopController < ApplicationController
  before_filter :check_permissions

  def index
    render :layout => false
  end
end
