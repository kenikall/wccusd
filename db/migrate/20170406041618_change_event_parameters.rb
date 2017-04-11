class ChangeEventParameters < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :teacher, index: true
    remove_column :events, :teacher_name, :string
  end
end
