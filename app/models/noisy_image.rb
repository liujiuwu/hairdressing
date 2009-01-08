require 'rubygems' 
require 'Rmagick'
class NoisyImage
  include Magick
  attr_reader :code, :code_image
  Jiggle,Wobble = 10,30
  
  def initialize(len)
    code_array,chars = [],('0'..'9').to_a + ('a'..'z' ).to_a + ('A'..'Z').to_a
    1.upto(len) { code_array << chars[rand(chars.length)]}
    #granite = Magick::ImageList.new('netscape:')
    granite = Magick::ImageList.new('xc:#EEF5FF')
    canvas = Magick::ImageList.new
    canvas.new_image(35*len, 50, Magick::TextureFill.new(granite))
    text = Magick::Draw.new
    text.font_weight(Magick::BoldWeight)
    text.pointsize = 30
    cur = 10
    
    code_array.each{|c|
      rand(10) > 5 ? rot=rand(Wobble):rot= -rand(Wobble)
      rand(10) > 5 ? weight = NormalWeight : weight = BoldWeight
      #weight = NormalWeight
      text.annotate(canvas,0,0,cur,30+rand(Jiggle),c){
        self.rotation=rot
        self.font_weight = weight
        self.fill = 'green'
      }
      cur += 30
    }
    @code = code_array.to_s
    @code_image = canvas.to_blob{
      self.format="JPG" 
    }
  end
  
end