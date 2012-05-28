class Photo < ActiveRecord::Base
  attr_protected nil
  has_and_belongs_to_many :albums
  has_attached_file :photo, :styles => { :medium => "100x100>", :thumb => "100x100>" }
  accepts_nested_attributes_for :albums
end
