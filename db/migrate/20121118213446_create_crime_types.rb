class CreateCrimeTypes < ActiveRecord::Migration
  def change
    create_table :crime_types do |t|
      t.string :name, null:false
      t.string :regex, null: false, default: "^.+$"

      t.timestamps
    end
  end
end
