class AddForeignKeytoCrimes < ActiveRecord::Migration
  def up
    change_table :crimes do |t|
      t.references :crime_type
    end
  end

  def down
    remove_column :crimes, :crime_type_id
  end
end
