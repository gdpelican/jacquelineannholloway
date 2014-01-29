class CreateResumeItems < ActiveRecord::Migration
  def change
    create_table :resume_items do |t|
      t.integer :resume_section_id
      t.string :styles
      t.string :text
      t.integer :order
      t.timestamps
    end
  end
end
