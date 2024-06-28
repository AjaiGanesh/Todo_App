class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.references :user, foreign_key: true, index: true
      t.integer :parent_id, index: true
      t.string :description, index: true
      t.integer :status, default: 1, null: false
      t.timestamps
    end
  end
end
