class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login, :name, :email, :crypted_password, :password_salt, :persistence_token, :last_login_ip, :current_login_ip
      t.integer :login_count
      t.datetime :last_request_at, :last_login_at, :current_login_at
      t.text :bio
      
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
