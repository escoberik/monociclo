class Album < ActiveRecord::Base
  attr_protected nil
  has_many :album_photos 
  has_many :photos, :through => :album_photos
  accepts_nested_attributes_for :photos
end
