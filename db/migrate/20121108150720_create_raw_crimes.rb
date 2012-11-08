class CreateRawCrimes < ActiveRecord::Migration
  def change
    create_table :raw_crimes do |t|
      t.string :guid
      t.string :title
      t.string :link
      t.datetime :date
      t.text :text

      t.timestamps
    end
  end
end
