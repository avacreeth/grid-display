class CreateTiles < ActiveRecord::Migration
  def change
    create_table :tiles do |t|
      t.string :type
      t.text :content
      t.integer :grid_id

      t.timestamps
    end
  end
end
