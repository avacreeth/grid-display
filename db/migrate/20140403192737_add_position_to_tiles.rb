class AddPositionToTiles < ActiveRecord::Migration
  def change
    add_column :tiles, :position, :integer
  end
end
