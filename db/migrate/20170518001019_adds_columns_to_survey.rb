class AddsColumnsToSurvey < ActiveRecord::Migration[5.0]
  def change
    add_column :surveys, :complete, :boolean, default: false
    add_column :surveys, :question1, :integer
    add_column :surveys, :question2, :integer
    add_column :surveys, :question3, :integer
    add_column :surveys, :question4, :integer
    add_column :surveys, :question5, :integer
  end
end
