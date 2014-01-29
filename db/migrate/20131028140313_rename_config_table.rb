class RenameConfigTable < ActiveRecord::Migration
  def change
    rename_table :config, :site_configuration
  end
end
