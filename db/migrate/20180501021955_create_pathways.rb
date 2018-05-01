class CreatePathways < ActiveRecord::Migration[5.0]
  def change
    create_table :pathways do |t|
      t.string :path, null: false
      t.string :school, null: false
      t.text :data
      t.timestamps
    end
  end
end
