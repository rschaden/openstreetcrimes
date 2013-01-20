class RemoveIdFromRawCrime < ActiveRecord::Migration
  def up
    remove_column :raw_crimes, :id
  end

  def down
    add_column :raw_crimes, :id, :integer
  end
end
