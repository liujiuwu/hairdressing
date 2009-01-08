class AreasController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def switch
    code = params[:code]
    select_area_position = params[:select_area_position]
    unless code.nil?
      if code == "0"
        area = Area.new
        area.name = "全国"
        area.code = "0";
      else
        area = Area.find(:first,:conditions => ["code=?",code])
        area.name = Area.full_area_name(area.code)
      end
      session[:area] = area if select_area_position=="top" #顶部切换城市时才设置session
      session[:except_set_current_city] = true;
    end
    render :text => "{name:\"#{area.name}\",code:\"#{area.code}\"}"
  end
  
  def json
    code = params[:code] || "0"
    @json = "["
    areas = (code == "0")? Area.find(:all,:conditions =>["length(code) = 2"]) : Area.find(:all,:conditions =>["length(code) = ? and code like ?",code.length+2,code+"%"])
    areas.each do |area|
      @json << "{name:'#{area.name}',code:'#{area.code}'},"
    end
    @json = @json.slice(0,@json.length-1) << "]";
    render :text => @json
  end

  def convert_code_name
    code = params[:code]
    render :text => "{code:'#{code}',name:'#{Area.full_area_name(code)}'}"
  end
end
