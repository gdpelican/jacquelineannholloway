class RenameProfilePictureColumns < ActiveRecord::Migration
  def change
    rename_column :site_configurations, :picture_file_name, :profile_picture_file_name
    rename_column :site_configurations, :picture_content_type, :profile_picture_content_type
    rename_column :site_configurations, :picture_file_size, :profile_picture_file_size
    rename_column :site_configurations, :picture_updated_at, :profile_picture_updated_at
  end
end
