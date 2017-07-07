class AddTeacherColumnsToSurvey < ActiveRecord::Migration[5.0]
  def change
    add_column :surveys, :career_awareness, :boolean, default: false
    add_column :surveys, :workplace_protocols, :boolean, default: false
    add_column :surveys, :field_interest, :boolean, default: false
    add_column :surveys, :career_skills, :boolean, default: false
    add_column :surveys, :gain_confidence, :boolean, default: false
    add_column :surveys, :project, :boolean, default: false
    add_column :surveys, :creative_thinking, :boolean, default: false
    add_column :surveys, :teamwork_skills, :boolean, default: false
    add_column :surveys, :take_feedback, :boolean, default: false
    add_column :surveys, :self_management, :boolean, default: false
    add_column :surveys, :assess_learning, :boolean, default: false
    add_column :surveys, :develop_plan, :boolean, default: false
  end
end
