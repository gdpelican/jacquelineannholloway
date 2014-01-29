class CreateResumeSections < ActiveRecord::Migration
  def change
    create_table :resume_sections do |t|
      t.integer :resume_id
      t.string :styles
      t.timestamps
    end
  end
end
