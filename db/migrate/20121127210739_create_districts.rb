class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.string :name
      t.polygon :area, :geographic => true

      t.timestamps
    end

    change_table :districts do |t|
      t.index :area, :spatial => true
    end
  end
end