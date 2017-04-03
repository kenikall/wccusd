class AddColumnsToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :teacher_name, :string
    add_column :events, :school, :string
    add_column :events, :pathway, :string
    add_column :events, :course, :string
    add_column :events, :grade, :integer
    add_column :events, :ninth_graders, :integer
    add_column :events, :tenth_graders, :integer
    add_column :events, :eleventh_graders, :integer
    add_column :events, :twelfth_graders, :integer
    add_column :events, :date, :datetime
    add_column :events, :duration, :integer
  end
end
