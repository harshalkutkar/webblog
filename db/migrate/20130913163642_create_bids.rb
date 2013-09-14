class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :pid
      t.integer :uid
      t.float :bid
      t.timestamp :time

      t.timestamps
    end
  end
end
