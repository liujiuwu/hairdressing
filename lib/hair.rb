module Hair
  def title(page_title)   
    content_for(:title) { page_title }   
  end
  
  def website_title
    "爱美发"
  end
  
  def xwill_paginate entries = @entries
    will_paginate entries,:prev_label => "上一页"[:Previous],:next_label => "下一页"[:Next]
  end
  
  def error_messages_for(object_name, options = {})
    options = options.symbolize_keys
    object = instance_variable_get("@#{object_name}")
    if object
      unless object.errors.empty? 
        error_lis = []
        i =0
        object.errors.each{ |key,msg| error_lis << content_tag("li", "#{i += 1}、#{msg}") }
        content_tag("div",
          content_tag( options[:header_tag] || "h2"," 当前共发生#{object.errors.count}个错误") + content_tag("ul", error_lis),"id" => options[:id] || "errorExplanation", "class" => options[:class] || "errorExplanation")
      end
    end
  end
  
  def clear_error_message_on(object, method, prepend_text = "", append_text = "", css_class = "formError")
    if errors = instance_variable_get("@#{object}").errors.on(method)
      "#{prepend_text}#{errors.is_a?(Array) ? errors.first : errors}#{append_text}"
    end
  end

  #日期格式化
  def dfmt(d, fmt="%Y-%m-%d")
    return Formatter.dfmt(d, fmt) if d
  end

  #日期时间格式化
  def dtfmt(d, fmt="%Y-%m-%d %H:%M")
    return Formatter.dtfmt(d, fmt) if d
  end

  #日期时间文字格式化
  def dtfmt_text(d)
    words = {"about"=>"", "minute"=>"分钟", "hour"=>"小时", "day"=>"天", "month"=>"月", "year"=>"年", "les"=>"", "than"=>""}
    res = distance_of_time_in_words(Time.now, d)
    words.each{|k, v| res = res.sub(k,v)}
    res = res.sub("a", "1")
    res = res.strip().sub("s","")
    "  "+ res + "前"
  end
  
#  def will_paginate(entries = @entries, options = {})
#    total_pages = entries.page_count
#
#    if total_pages > 1
#      options = options.symbolize_keys.reverse_merge(pagination_options)
#      page, param = entries.current_page, options.delete(:param_name)
#
#      inner_window, outer_window = options.delete(:inner_window).to_i, options.delete(:outer_window).to_i
#      min = page - inner_window
#      max = page + inner_window
#      # adjust lower or upper limit if other is out of bounds
#      if max > total_pages then min -= max - total_pages
#      elsif min < 1  then max += 1 - min
#      end
#
#      current   = min..max
#      beginning = 1..(1 + outer_window)
#      tail      = (total_pages - outer_window)..total_pages
#      visible   = [beginning, current, tail].map(&:to_a).flatten.sort.uniq
#      links, prev = [], 0
#
#      visible.each do |n|
#        next if n < 1
#        break if n > total_pages
#
#        unless n - prev > 1
#          prev = n
#          links << page_link_or_span((n != page ? n : nil), 'current', n, param)
#        else
#          # ellipsis represents the gap between windows
#          prev = n - 1
#          links << '...'
#          redo
#        end
#      end
#
#      # next and previous buttons
#      links.unshift page_link_or_span(entries.previous_page, 'disabled', options.delete(:prev_label), param)
#      links.push    page_link_or_span(entries.next_page,     'disabled', options.delete(:next_label), param)
#      links.unshift("#{page}/#{total_pages}页")
#      content_tag :div, links.join(options.delete(:separator)), options
#    end
#  end
  
  def distance_of_time_in_words(from_time, to_time = 0, include_seconds = false)
    from_time = from_time.to_time if from_time.respond_to?(:to_time)
    to_time = to_time.to_time if to_time.respond_to?(:to_time)
    distance_in_minutes = (((to_time - from_time).abs)/60).round
    case distance_in_minutes
    when 0..1           then (distance_in_minutes==0) ? '几秒钟前'[] : '1 分钟前'[]
    when 2..59          then "{minutes} 分钟前"[:minutes_ago, distance_in_minutes]
    when 60..90         then "1 小时前"[]
    when 90..1440       then "{hours} 小时前"[:hours_ago, (distance_in_minutes.to_f / 60.0).round]
    when 1440..2160     then '1 天前'[] # 1 day to 1.5 days
    when 2160..2880     then "{days} 天前"[:days_ago, (distance_in_minutes.to_f / 1440.0).round] # 1.5 days to 2 days
    else from_time.strftime("%Y-%m-%d"[:datetime_format]) { |x| x.downcase }
    end
  end
  
  def number_format(number)
    number_with_delimiter(number)
  end
  
  def display_standard_flashes(message = 'There were some problems with your submission:')
    if flash[:notice]
      flash_to_display, level = flash[:notice], 'notice'
    elsif flash[:warning]
      flash_to_display, level = flash[:warning], 'warning'
    elsif flash[:error]
      level = 'error'
      if flash[:error].instance_of?( ActiveRecord::Errors) || flash[:error].is_a?( Hash)
        flash_to_display = message
        flash_to_display << activerecord_error_list(flash[:error])
      else
        flash_to_display = flash[:error]
      end
    else
      return
    end
    content_tag 'div', flash_to_display, :class => "flash#{level}"
  end
  
  def time_format(formerly_time)
    formerly_time.nil?? "":formerly_time.strftime("%Y-%m-%d %H:%M:%S")
  end
  
  def date_format(formerly_time)
    formerly_time.nil?? "":formerly_time.strftime("%Y-%m-%d")
  end
  
   
end
