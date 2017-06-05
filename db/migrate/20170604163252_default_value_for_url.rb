class DefaultValueForUrl < ActiveRecord::Migration[5.0]
  def change
    change_column :providers, :url, :string, default: "N/A"
  end
end
