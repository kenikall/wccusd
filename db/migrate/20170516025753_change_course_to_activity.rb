class ChangeCourseToActivity < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :course, :activity
  end
end
