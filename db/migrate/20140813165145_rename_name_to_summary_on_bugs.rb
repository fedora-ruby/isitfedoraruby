class RenameNameToSummaryOnBugs < ActiveRecord::Migration
  def change
    rename_column :bugs, :name, :summary
  end
end
