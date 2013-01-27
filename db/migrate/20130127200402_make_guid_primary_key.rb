class MakeGuidPrimaryKey < ActiveRecord::Migration
  def up
    execute "ALTER TABLE raw_crimes ADD PRIMARY KEY (guid)"
  end

  def down
    execute "ALTER TABLE raw_crimes REMOVE PRIMARY KEY (guid)"
  end
end
