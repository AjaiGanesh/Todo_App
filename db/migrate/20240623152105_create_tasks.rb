class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :priority
      t.string :label
      t.string :status
      t.text :description
      t.datetime :start_date_at
      t.datetime :due_date_at
      t.timestamps
    end
  end
end
