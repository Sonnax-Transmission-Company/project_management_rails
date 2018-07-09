class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.integer :priority
      t.text :request
      t.text :notes
      t.string :status
      t.string :product_line
      t.boolean :no_steps
      t.datetime :due_date
      t.datetime :complete_date

      t.timestamps
    end
  end
end