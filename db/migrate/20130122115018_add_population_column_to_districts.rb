class AddPopulationColumnToDistricts < ActiveRecord::Migration
  def change
    add_column :districts, :population, :integer
  end
end
