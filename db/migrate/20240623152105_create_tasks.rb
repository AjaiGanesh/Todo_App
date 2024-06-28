class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.references :project, foreign_key: true, index: true
      t.references :priority, foreign_key: true, index: true
      t.string :label
      t.references :status, foreign_key: true, index: true
      t.string :description, null: false, index: true
      t.datetime :start_date_at
      t.datetime :due_date_at
      t.integer :parent_id, index: true
      t.timestamps
    end
  end
end
