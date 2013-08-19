class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true
      t.boolean    :owner, default: false

      t.timestamps
    end
  end
end
