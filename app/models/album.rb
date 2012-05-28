class Album < ActiveRecord::Base
  attr_protected nil
  has_and_belongs_to_many :photos
  accepts_nested_attributes_for :photos
end
