class CommentsController < ApplicationController
  before_filter :login_required,:except => :index
  before_filter :find_salon
  
  def create
    @comment = @salon.comments.build(params[:comment])
    @comment.user_id = current_user.id
    
    respond_to do |format|
      if @comment.save
        format.js do
          render :update do |page|
            page.insert_html :top, "#{dom_id(@salon)}_comments", :partial => 'shared/comment'
            page.visual_effect :highlight, "comment_#{@comment.id}".to_sym
            page << "$('#comment_comment').removeClass('rborder');$('#comment_error').hide();$('#comment_comment').val('');window.location.hash='comment_#{@comment.id}';"
          end
        end
      else
        format.js do
          render :update do |page|
            page.visual_effect :highlight, :comment_error
            page << "$('#comment_error').show();$('#comment_error').html('#{@comment.errors.on(:comment)}');$('#comment_comment').removeClass('rborder');$('#comment_comment').addClass('rborder');"
          end
        end
      end
    end
  end
  
  private
  def find_salon
    @salon = Salon.find(params[:salon_id])
  end
end
