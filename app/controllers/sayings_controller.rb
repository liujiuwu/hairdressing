class SayingsController < ApplicationController

  def create
    @saying = Saying.new(params[:saying])

    respond_to do |format|
      if @saying.save
        format.js do
          render :update do |page|
            page.remove :feed_back
            page.insert_html :top, "new_saying","<div id=\"feed_back\" style=\"padding:5px 0;color:green\"></div>"
            page.visual_effect :highlight, :feed_back
            page << "$('#saying_error').hide();$('#saying_error').html('');"
            page << %Q($("input[@type='text'],textarea").each(function(){$(this).removeClass('rborder');$(this).val("");});)
            page << "$('#feed_back').html(\"您要说的话已经发给我们了，谢谢您的支持！\")"

          end
        end
      else
        errors = "<div class=\"errorExplanation\" id=\"errorExplanation\"><h2> 当前共发生#{@saying.errors.length}个错误</h2><ul>"
        @saying.errors.each { |name,error| errors << "<li>#{error}</li>" }
        errors << "</ul></div>"
        format.js do
          render :update do |page|
            page << %Q($("input[@type='text'],textarea").each(function(){$(this).removeClass('rborder');});)
            page.visual_effect :highlight, :saying_error
            page << "$('#saying_error').show();$('#saying_error').html('#{errors}');"
            @saying.errors.each do |name,error |
              page << "$('#saying_#{name}').addClass('rborder')";
            end
          end
        end
      end
    end
  end
end
