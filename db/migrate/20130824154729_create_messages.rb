class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.string :post_by
      t.integer :project_id
      t.timestamps
    end
  end
end
