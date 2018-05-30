class AddUserInfoToSurvey < ActiveRecord::Migration[5.0]
  def change
    add_column :surveys, :survey_type, :string
  end
end
