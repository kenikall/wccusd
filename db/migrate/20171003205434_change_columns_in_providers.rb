class ChangeColumnsInProviders < ActiveRecord::Migration[5.0]
  def change
    remove_column :providers, :name
    remove_column :providers, :contact
    add_column :providers, :first_name, :string
    add_column :providers, :last_name, :string
    add_column :providers, :title, :string
    add_column :providers, :organization, :string
  end
end
