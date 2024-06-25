class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false, index:true
      t.string :last_name, index: true
      t.string :email, null: false, unique: true, index: true
      t.integer :status, default: 0, null: false
      t.string :password_digest, null: false
      t.datetime :deleted_at
      t.datetime :last_login_at
      t.datetime :last_logout_at
      t.integer :num_of_logins
      t.integer :num_of_logouts
      t.string :reset_password_token
      t.datetime :reset_password_requested_at
      t.timestamps
    end
  end
end
