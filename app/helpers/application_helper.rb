module ApplicationHelper
  def font_icon(icon, size = 'medium')
    "<i class=\"icon-#{icon} icon-#{size}\"></i>".html_safe
  end
end
