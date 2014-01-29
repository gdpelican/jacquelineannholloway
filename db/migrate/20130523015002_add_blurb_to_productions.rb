class AddBlurbToProductions < ActiveRecord::Migration
  def change
    add_column :productions, :blurb, :string
  end
end
