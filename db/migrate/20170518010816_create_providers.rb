class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers do |t|
      t.string :name
      t.string :location
      t.string :url
      t.string :contact
      t.string :phone
      t.string :email
      t.timestamps
    end
  end
end
