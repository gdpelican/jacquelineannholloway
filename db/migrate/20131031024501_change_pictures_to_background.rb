class ChangePicturesToBackground < ActiveRecord::Migration
  def change
    rename_table :pictures, :background_images
    rename_column :background_images, :picture_title, :slide_title
    add_column :background_images, :blurb, :string
  end
end
