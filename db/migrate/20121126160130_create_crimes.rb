class CreateCrimes < ActiveRecord::Migration
  def change
    create_table :crimes do |t|
      t.string :description
      t.date :date
      t.point :location, :geographic => true

      t.timestamps
    end

    change_table :crimes do |t|
      t.index :location, :spatial => true
    end
  end
end
