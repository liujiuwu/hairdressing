class Formatter
  #日期格式化
  def self.dfmt(d, fmt="%Y-%m-%d")
    return d.strftime(fmt)
  end
  
  #日期时间格式化
  def self.dtfmt(d, fmt="%Y-%m-%d %H:%M")
    return d.strftime(fmt)
  end
end
