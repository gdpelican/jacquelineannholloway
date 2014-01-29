class PluralizeResumes < ActiveRecord::Migration
  def change
    drop_table :resume
    create_table :resumes do |t|
      t.string :name
      t.boolean :active
      t.timestamps
    end
  end
end
