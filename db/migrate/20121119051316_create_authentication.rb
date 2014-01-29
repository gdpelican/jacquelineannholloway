class CreateAuthentication < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :name
      t.string :salt
      t.string :pass_hash
      t.string :email
      t.timestamps
    end
    
    create_table :sessions do |t|
      t.belongs_to :person
      t.timestamps
    end
  end

  def self.down
    drop_table :people
    drop_table :sessions
  end
end