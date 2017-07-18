class Add < ActiveRecord::Migration[5.0]
  def change
    add_column :surveys, :teacher_question3, :string
  end
end
