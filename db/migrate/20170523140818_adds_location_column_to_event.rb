class AddsLocationColumnToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :location, :string
    change_column :surveys, :question1, :string
    change_column :surveys, :question2, :string
    change_column :surveys, :question3, :string
    change_column :surveys, :question4, :string
    change_column :surveys, :question5, :text
  end
end
