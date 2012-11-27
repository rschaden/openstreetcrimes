class AddForeignKeyToCrimes < ActiveRecord::Migration
  def up
    change_table :crimes do |t|
      t.references :district
    end
  end

  def down
    remove_column :crimes, :district_id
  end
end
