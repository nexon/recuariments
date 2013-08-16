class CreateRequirementFields < ActiveRecord::Migration
  def change
    create_table :requirement_fields do |t|
      t.string :name
      t.string :field_type
      t.boolean :required
      t.belongs_to :project, index: true

      t.timestamps
    end
  end
end
