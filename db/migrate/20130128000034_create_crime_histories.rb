class CreateCrimeHistories < ActiveRecord::Migration
  def change
    create_table :crime_histories do |t|
      t.integer :district_id
      t.integer :year
      t.integer :crime_count

      t.timestamps
    end
  end
end
