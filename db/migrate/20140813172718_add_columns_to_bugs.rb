class AddColumnsToBugs < ActiveRecord::Migration
  def change
    add_column :bugs, :component, :string
    add_column :bugs, :status, :string
    add_column :bugs, :needs_sponsor, :boolean
    add_column :bugs, :assigned_to, :string
    add_column :bugs, :opened_by, :string
    add_column :bugs, :reported_on, :datetime
    add_column :bugs, :modified_on, :datetime
  end
end
