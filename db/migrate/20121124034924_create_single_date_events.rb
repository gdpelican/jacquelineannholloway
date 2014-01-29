class CreateSingleDateEvents < ActiveRecord::Migration
  def change
    remove_column :events, :start_at
    remove_column :events, :end_at
    remove_column :productions, :start_at
    remove_column :productions, :end_at
    remove_column :productions, :venue
    remove_column :productions, :address
    add_column :events, :event_date, :datetime
    add_column :events, :venue_id, :integer
  end

end
