class AddPriorityToCrimeType < ActiveRecord::Migration
  def change
    add_column :crime_types, :priority, :integer, default: 100
  end
end
