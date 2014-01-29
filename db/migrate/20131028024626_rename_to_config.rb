class RenameToConfig < ActiveRecord::Migration
  def change
    rename_table :profile_images, :config 
    add_column :config, :site_primary, :string
    add_column :config, :site_primary_rgb, :string
    add_column :config, :site_foreground, :string
    add_column :config, :current, :boolean
  end
end
