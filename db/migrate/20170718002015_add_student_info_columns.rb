class AddStudentInfoColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :student_number, :integer
    add_column :users, :gender, :string
    add_column :users, :ethnicity, :string
    add_column :users, :pathway, :string
  end
end
