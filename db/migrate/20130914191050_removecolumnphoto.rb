class Removecolumnphoto < ActiveRecord::Migration
  def change

        remove_column :photos,:pid



  end
end
