class ModifyEventFields < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :end_time, :datetime
    remove_column :events, :duration, :integer
  end
end
