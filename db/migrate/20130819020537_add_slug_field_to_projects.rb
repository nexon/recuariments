class AddSlugFieldToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :slug, :string, unique: true
  end
end
