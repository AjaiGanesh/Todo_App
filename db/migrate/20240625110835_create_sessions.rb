class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.references :user, foreign_key: true, index: true, null: false
      t.string :salt, null:false
      t.string :session_key, null: false, unique: true
      t.text :auth_token, null: false
      t.datetime :expires_at
      t.timestamps
    end
  end
end
