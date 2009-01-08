module InfosHelper
  def period_of_validity_name(info)
    info.period_of_validity_name(count_down(info.created_at,info.period_of_validity))
  end
end
