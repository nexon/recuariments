class AddFieldNameToRequirementField < ActiveRecord::Migration
  def change
    add_column :requirement_fields, :field_name, :string
  end
end
