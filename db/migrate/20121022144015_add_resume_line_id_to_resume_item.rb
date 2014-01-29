class AddResumeLineIdToResumeItem < ActiveRecord::Migration
  def change
    remove_column :resume_items, :resume_section_id
    add_column :resume_items, :resume_line_id, :integer
  end
end
