class AddInfoToProductions < ActiveRecord::Migration
  def change
    add_column :productions, :info_link, :string
    add_column :productions, :ticket_link, :string
  end
end
