module ApplicationHelper
  include Hair
  
  def display_name
    if logged_in?
      "欢迎 #{current_user.name.blank? ? current_user.login : current_user.name} ！"
    end
  end
  
  def display_current_city
    session[:area] unless session[:area].nil?
  end
  
  def display_current_city_name
    session[:area].name unless session[:area].nil?
  end

  def salon_dispaly_detail(description,dispaly_detail)
    dispaly_detail ? description : truncate(description,100)
  end
  
  def display_name_for(user)
    user.name.blank? ? user.login : user.name
  end
  
  def salon_image(salon)
    img = "<div class=\"shop_front\">"
    unless salon.shop_front.blank?
      img << image_tag(url_for_file_column(salon, 'shop_front' ,'thumb'),:alt => salon.name )
    else
      img << image_tag("salon_none.jpg",:alt => '没有图片')
    end
    img << "</div>"
  end

  def user_logo(user)
    img = "<div class=\"face\">"
    if user.logo
      img << image_tag(url_for_file_column(user, 'logo','thumb'),:alt => user.name )
    else
      img << image_tag("none_header.gif",:alt => '没有头像')
    end
    img << "</div>"
  end
  
  def recent_users(count = 12)
    User.find_recent(count)
  end
  
  def recent_salons(count = 8)
    Salon.find_recent(session[:area],count)
  end
  
  def recent_flacks(count = 8)
    Flack.find_recent(session[:area],count)
  end
  
  def recent_jobs(count = 8)
    Job.find_recent(session[:area],count)
  end
  
  def recent_news(count = 8)
    News.find_recent(count)
  end
  
  def recent_hairstyles(count = 8)
    Hairstyle.find_recent(count)
  end
  
  def all_areas
    Area.find(:all)
  end
  
  def out_select_area_html(id)
    <<-EOS
    <div id="#{id}"  style="display:none">
        <div style="padding:3px 0;color:#ff5a00;clear:both;"><img src="/images/i_icon_dot.gif"/>&nbsp;双击列表中的地区项选择地区</div>
        <div style="clear:both;">
          <select name="sjdm" id="sjdm" size="10" class="selectArea"></select>
          <select name="djsdm" id="djsdm" size="10" class="selectArea"></select>
          <select name="xjdm" id="xjdm" size="10" class="selectArea"></select>
        </div>
      </div>
      EOS
  end
  
  def count_down(st_date,days)
    Date.parse(dfmt(days.days.since(st_date)))-Date.today
  end
end
