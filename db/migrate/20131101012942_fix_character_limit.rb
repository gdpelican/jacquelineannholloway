class FixCharacterLimit < ActiveRecord::Migration
  def change
    change_column :intro_blurbs, :text, :text, limit: nil
  end
end
