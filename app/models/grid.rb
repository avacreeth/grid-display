class Grid < ActiveRecord::Base
  attr_accessible :name
  has_many :tiles, order: 'position'
end
