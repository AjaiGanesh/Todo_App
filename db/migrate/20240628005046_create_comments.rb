class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :task, foreign_key: true, index: true
      t.text :description
      t.timestamps
    end
  end
end
