class AddSchoolToProviders < ActiveRecord::Migration[5.0]
  def change
    add_column :providers, :school, :string
  end
end
