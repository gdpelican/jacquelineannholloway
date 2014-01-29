module ResumeHelper
  include TriggerHelper

  def pdf_tag_name(type)
    case(type)
      when :resume then 'table'
      when :section then 'tbody'
      when :line then 'tr'
      when :item then 'td'
    end
  end
  
  def pdf_col_span(chunk, lcm)
    "colspan=#{(lcm / chunk.parent.children.count)}" if chunk.type == :item
  end

end
