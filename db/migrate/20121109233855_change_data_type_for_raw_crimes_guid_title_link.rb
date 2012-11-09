class ChangeDataTypeForRawCrimesGuidTitleLink < ActiveRecord::Migration
  def up
    change_table :raw_crimes do |t|
      t.change :guid, :text
      t.change :title, :text
      t.change :link, :text
    end
  end

  def down
    change_table :raw_crimes do |t|
      t.change :guid, :string
      t.change :title, :string
      t.change :link, :string
    end
  end
end
