class AddWeeksToConfig < ActiveRecord::Migration
  def change
    add_column :site_configurations, :upcoming_weeks, :integer
  end
end
