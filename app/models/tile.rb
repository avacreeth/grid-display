class Tile < ActiveRecord::Base
  attr_accessible :content, :grid_id, :type
end
