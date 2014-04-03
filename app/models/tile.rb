class Tile < ActiveRecord::Base
  attr_accessible :content, :grid_id, :type
  belongs_to :grid
end
