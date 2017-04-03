class CreateSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :surveys do |t|
      t.references :student, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
