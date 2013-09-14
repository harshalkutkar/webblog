class RemoveColumn < ActiveRecord::Migration
  def change
    remove_column :photos, :bid
    remove_column :photos, :bidder_id
  end
end
