class CreateRequirementFieldValues < ActiveRecord::Migration
  def change
    create_table :requirement_field_values do |t|
      t.string :value
      t.belongs_to :requirement, index: true
      t.belongs_to :requirement_field, index: true

      t.timestamps
    end
  end
end
