class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.integer :project_id

      t.timestamps
    end
  end
end
