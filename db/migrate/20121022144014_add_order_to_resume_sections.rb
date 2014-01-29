class AddOrderToResumeSections < ActiveRecord::Migration
  def change
    add_column :resume_sections, :order, :integer
  end
end
