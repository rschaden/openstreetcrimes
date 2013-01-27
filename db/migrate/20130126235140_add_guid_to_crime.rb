class AddGuidToCrime < ActiveRecord::Migration
  def change
    add_column :crimes, :guid, :text, primary: true
  end
end
