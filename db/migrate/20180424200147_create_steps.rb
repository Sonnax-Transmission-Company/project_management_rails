class CreateSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :steps do |t|
      t.belongs_to :project, index: true
      t.string :step_text
      t.boolean :complete
      t.string :category
      t.boolean :current
      t.text :notes
      t.integer :order

      t.timestamps
    end
  end
end
