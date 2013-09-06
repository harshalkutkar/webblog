class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :id
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :password
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :profile_pic
      t.string :background_pic
      t.string :about

      t.timestamps
    end
  end
end
