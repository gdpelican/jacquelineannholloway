class AddDurationToProductions < ActiveRecord::Migration
  def change
    add_column :productions, :duration, :integer
  end
end
