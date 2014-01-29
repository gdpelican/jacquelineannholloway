module TriggerHelper
  
  def trigger_path(text, path, options = {}, remote = true)
      link = link_to text, 
            path || 'javascript:;', 
            remote: path.blank? ? false : remote,
            id: (options[:id] rescue nil),
            class: (options[:class] rescue nil),
            title: (options[:title] rescue nil)
  end
  
  def text_trigger_path(text, path, action, title, remote = true)
    trigger_path(text, path, {title: title, class: "trigger #{action}-trigger"}, remote)
  end
  
  def icon_trigger_path(icon_name, path, options = {}, remote = true)
    trigger_path("<i class=\"icon-#{icon_name}\"></i>".html_safe, path, options, remote)
  end
  
  def trigger_class(action, styles = nil)
    "trigger #{action}-trigger #{selected_style(action, styles)}" unless styles.nil?
  end
  
  def toggle_trigger(text, parent, selectors, options = {})
    link_to text, 'javascript:;', 
            title: options[:title], 
            class: "toggle-trigger #{options[:class]}", 
            data: { title: options[:alt_title],
                    parent: parent, 
                    selectors: selectors }
  end
end
