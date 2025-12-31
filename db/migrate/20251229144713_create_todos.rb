class CreateTodos < ActiveRecord::Migration[8.1]
  def change
    create_table :todos do |t|
      t.string :title, limit: 100

      t.timestamps
    end
  end
end
