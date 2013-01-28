class AddConvertedToRawCrime < ActiveRecord::Migration
  def change
    add_column :raw_crimes, :converted, :boolean, default: false
  end
end
