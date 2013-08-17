class ChangeValueTypeOfRequirementFieldValues < ActiveRecord::Migration
  def change
    change_column :requirement_field_values, :value, :text
  end
end
