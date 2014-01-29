class CreateIntroBlurbs < ActiveRecord::Migration
  def change
    create_table :intro_blurbs do |t|
      t.string :text
      t.integer :order
      
      t.string :picture_file_name
      t.string :picture_content_type
      t.integer :picture_file_size
      t.datetime :picture_updated_at
      
      t.timestamps
    end
  end
end
