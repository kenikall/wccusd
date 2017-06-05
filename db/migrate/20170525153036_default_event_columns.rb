class DefaultEventColumns < ActiveRecord::Migration[5.0]
  def change
    change_column :events, :ninth_graders, :integer, default: 0
    change_column :events, :tenth_graders, :integer, default: 0
    change_column :events, :eleventh_graders, :integer, default: 0
    change_column :events, :twelfth_graders, :integer, default: 0
  end
end
