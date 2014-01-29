class RemoveSlidesAddPhotos < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :picture_title
      t.string :picture_alt
      t.string :picture_file_name
      t.string :picture_content_type
      t.integer :picture_file_size
      t.datetime :picture_updated_at
    end
    drop_table :slides
  end
end
