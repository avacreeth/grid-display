class ChangeTypeInTiles < ActiveRecord::Migration
  def change
    rename_column :tiles, :type, :content_type
  end
end
