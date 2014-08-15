class RenameBzIdToBugzillaIdOnBugs < ActiveRecord::Migration
  def change
    rename_column :bugs, :bz_id, :bugzilla_id
  end
end
