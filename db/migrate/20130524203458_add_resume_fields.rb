class AddResumeFields < ActiveRecord::Migration
  def change
    add_column :resume, :name, :string
    add_column :resume, :visible, :boolean
  end
end
