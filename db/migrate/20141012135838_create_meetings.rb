class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :name
      t.boolean :public
      t.string :location
      t.string :time
      t.references :group, index: true

      t.timestamps
    end
  end
end
