class AboutController < ApplicationController
  def index
    @saying = Saying.new
  end

end
