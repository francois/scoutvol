module ApplicationHelper
  def privacy_perserving_name(name)
    parts = name.split(/\s+/)
    "#{parts[0]} #{parts[1][0]}"
  end
end
