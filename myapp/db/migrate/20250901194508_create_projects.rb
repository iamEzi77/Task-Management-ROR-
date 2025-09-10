class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.date :due_date
      t.integer :priority_level
      t.string :category
      t.string :status
      t.string :assigned_to

      t.timestamps
    end
  end
end
