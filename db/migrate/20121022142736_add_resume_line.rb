class AddResumeLine < ActiveRecord::Migration
  def change
    create_table :resume_lines do |t|
      t.integer :resume_section_id
      t.string :styles
      t.integer :order
      t.timestamps
    end
    
    change_table :resume_items do |t|
      
    end
  end
end
