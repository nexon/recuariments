class AddObjectChangesToVersion < ActiveRecord::Migration
  def change
     add_column :versions, :object_changes, :text
  end
end
