class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :user, index: true
      t.references :group, index: true
      t.string :role

      t.timestamps
    end
  end
end
