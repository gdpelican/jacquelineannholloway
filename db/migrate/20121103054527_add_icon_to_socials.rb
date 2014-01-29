class AddIconToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :icon_name, :string
  end
end
