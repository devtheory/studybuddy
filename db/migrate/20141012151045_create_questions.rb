class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name
      t.references :meeting, index: true

      t.timestamps
    end
  end
end
