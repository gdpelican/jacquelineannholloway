class RemoveUrlFromSlides < ActiveRecord::Migration
  def up
    remove_column :slides, :url
  end

  def down
    add_column :slides, :url, :string
  end
end
