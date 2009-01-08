class CodeImageController < ApplicationController

  def index
    session[:noisy_image] = NoisyImage.new(4)
    session[:code] = session[:noisy_image].code
    image = session[:noisy_image].code_image
    send_data image, :type => 'image/jpeg', :disposition => 'inline'
  end
end
