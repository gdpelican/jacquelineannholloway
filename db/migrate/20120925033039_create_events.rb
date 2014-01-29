class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.string :venue
      t.string :address
      t.datetime :start_at
      t.datetime :end_at
      t.text :description
      t.timestamps
      
      t.string :picture_file_name
      t.string :picture_content_type
      t.integer :picture_file_size
      t.datetime :picture_updated_at
    end
  end

  def self.down
    drop_table :events
  end
end
