class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :pid
      t.integer :uid
      t.string :name
      t.string :caption
      t.string :tags
      t.integer :bidder_id
      t.float :bid

      t.timestamps
    end
  end
end
