class RemoveIdFromCrime < ActiveRecord::Migration
  def up
    remove_column :crimes, :id
  end

  def down
    add_column :crimes, :id, :integer
  end
end
