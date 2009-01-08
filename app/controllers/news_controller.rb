class NewsController < ApplicationController

  def index
  end

  def show
    @news = News.find(params[:id])
    unless session["news_hits_#{@news.id}"]
      @news.increment!(:hits) 
      session["news_hits_#{@news.id}"] = true
    end
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @news }
    end
  end
end
