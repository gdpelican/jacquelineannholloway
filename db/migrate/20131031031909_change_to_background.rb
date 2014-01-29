class ChangeToBackground < ActiveRecord::Migration
  def change
    rename_table :background_images, :backgrounds
  end
end
