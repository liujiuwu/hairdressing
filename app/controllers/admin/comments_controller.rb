class Admin::CommentsController < ApplicationController
  before_filter :check_permissions
  layout 'admin'

   def index
    @Comments = Comment.paginate(:all,:page => params[:page],:order =>'created_at desc')

    respond_to do |format|
      format.html
      format.xml  { render :xml => @Comments }
    end
  end
end
