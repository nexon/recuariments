class AddUniqueFieldToRequirementField < ActiveRecord::Migration
  def change
    add_column :requirement_fields, :unique, :boolean
  end
end
