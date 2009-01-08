class MarkitupPreviewController < ApplicationController
  skip_before_filter :verify_authenticity_token
  layout nil
  def preview
    data = params[:data]
    render :text => RedCloth.new(data).to_html
  end
end
