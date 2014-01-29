class RenameConfigTableAgain < ActiveRecord::Migration
  def change
    rename_table :config, :site_configurations
  end
end
