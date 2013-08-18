class AddOrderFieldToRequirementFields < ActiveRecord::Migration
  def change
    add_column :requirement_fields, :order, :integer, default: 99999
  end
end
