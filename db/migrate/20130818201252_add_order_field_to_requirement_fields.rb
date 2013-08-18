class AddOrderFieldToRequirementFields < ActiveRecord::Migration
  def change
    add_column :requirement_fields, :order, :integer, default: 0
  end
end
