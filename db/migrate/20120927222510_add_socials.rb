class AddSocials < ActiveRecord::Migration
  def up
    create_table :socials do |t|
      t.string :name
      t.string :link
      t.string :js_function
      t.timestamps
      
      t.string :icon_file_name
      t.string :icon_content_type
      t.integer :icon_file_size
      t.datetime :icon_updated_at
    end
  end

  def down
    drop_table :socials
  end
end
