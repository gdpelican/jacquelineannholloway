class AdjustEvents < ActiveRecord::Migration
  def change
    rename_table :events, :productions
    
    create_table :events do |t|
      t.belongs_to :production
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end
  end
end
