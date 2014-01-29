module ResumeChunk

  def to_json(options={})
    include_hash =  { only: [:id, :order, :styles, :text, :active], 
                      methods: [:type, :row_span, :children_json] }
    options.merge! include_hash
    super options
  end
  
  #JSON methods
  def type
    (self.class == Resume) ? :resume : self.class.to_s.downcase.to_s.gsub('resume', '').to_sym
  end
  
  def row_span
    case(type)
      when :section then (children.any?) ? children.first.row_span : 0
      when :line then children.count
      else nil
    end
  end
  
  def children_json
    children.map { |child| JSON.parse(child.to_json) } rescue Hash.new
  end
  
  #Static methods
  def self.update(chunk, params = {})
    return chunk.destroy if params[:destroyed] == 'true'

    chunk.attributes = get_static_assignables params
    chunk.save! if chunk.changed?
    
    (params[:children] || []).each do |child|
      child = child[1].merge({ parent: chunk })
      ResumeChunk.update(chunk.children
                              .where(id: child[:id])
                              .first_or_initialize(get_static_assignables child), child)
    end
  end
  
  def self.get_chunk(level = nil, id = nil)
    raise 'Invalid resume find operation' if level.blank? or id.blank?
    get_static_class(level).find(id)
  end

  private

  def self.get_static_class(level)
    case level
      when :resume  then Resume
      when :section then ResumeSection
      when :line    then ResumeLine
      when :item    then ResumeItem
      else nil
    end
  end
  
  def self.get_static_assignables(params)
    params.select { |attr| get_static_class(params[:type].to_sym).accessible_attributes.include? attr}  
  end

end