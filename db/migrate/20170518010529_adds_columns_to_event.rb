class AddsColumnsToEvent < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :provider, index: true
  end
end
